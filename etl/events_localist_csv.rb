require_relative '../config/environment'
require 'httparty'
require 'csv'

ITHACA_LOCALIST_URI = "https://events.ithaca.edu/api/2/events"
CORNELL_LOCALIST_URI = "https://events.cornell.edu/api/2/events"
VISITITHACA_LOCALIST_URI = "https://events.visitithaca.com/api/2/events"

class Feed

  def initialize(uri, filename)    
    
    @pages = HTTParty.get(uri, :query => {'page' => 1, 'days' => '370' }, :headers => {"User-Agent" => "Safari"}, :verify => false)

    @pages = @pages['page']

    timestamp = Time.now.strftime("%Y%m%dT%H%M%S")
    filename = "#{filename}-#{timestamp}.csv"    

    sorted_event = []

    input_fields = ['venue_id', 'id', 'title', 'localist_url', 'start', 'ticket_cost', 'description']
    output_fields = [:venue_id, :remote_id, :name, :url, :start_time, :cost, :description]  


    for i in @pages['current']..@pages['total']
    # for i in @pages['current']..1
      @response = HTTParty.get(uri, :query => {'page' => i,'days' => '370' }, :headers => {"User-Agent" => "Safari"}, :verify => false)

      @response['events'].each do |event|
        row = []

        event['event']['event_instances'].each do |e| 
          event['event']['start'] = e['event_instance']['start']
        end      
        
        venue_id = event['event']['venue_id']
        cool = Venue.where(remote_id: venue_id).pluck(:id).first
        event['event']['venue_id'] = cool

        input_fields.each do |field|
          row << event['event'][field]
        end
        sorted_event << row
      end        

      sleep 10
    end

    CSV.open( filename, 'w' ) do |row|
      row << output_fields

      sorted_event.each do |event|
        row << event
      end
    end
    
    FileUtils.move filename, "events_localist_csv/#{filename}"
  end

end


# Venue.all.each do |venue|
#   if (venue.remote_id?)
#     venue.name = Feed.new(TICKETFLY_URI, venue.remote_id, venue.id)
#   end
# end

ithaca_college = Feed.new(ITHACA_LOCALIST_URI, 'localist-ithaca')
cornell_university = Feed.new(CORNELL_LOCALIST_URI, 'localist-cornell')
visit_ithaca = Feed.new(VISITITHACA_LOCALIST_URI, 'localist-visitithaca')
