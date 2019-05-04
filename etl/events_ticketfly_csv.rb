require_relative 'shared'

TICKETFLY_URI = "http://www.ticketfly.com/api/events/upcoming.json"

class Feed

  def initialize(uri, venue_remote_id, venue_id)
    @venue_remote_id = venue_remote_id
    @venue_id = venue_id
    @org_or_venue = 'venue'
    # @org_or_venue == 'org' ? query_type = 'orgId' : query_type = 'venueId'
    query_type = "venueId"

    # The Ticketfly api doesn't like it when your user agent is rails, so I just picked something that sounds remotely plausible
    @events = HTTParty.get(uri, :query => {query_type => @venue_remote_id }, :headers => {"User-Agent" => "Safari"})
    write_csv

  end

  def write_csv
    input_fields = ['venue_id', 'id', 'name', 'ticketPurchaseUrl', 'ticketPrice', 'doorsDate', 'eventDescription']
    output_fields = [:venue_id, :remote_id, :name, :url, :cost, :start_time, :description]  

    timestamp = Time.now.strftime("%Y%m%dT%H%M%S")
    filename = "ticketfly-#{@org_or_venue}-#{@venue_remote_id}.csv"


    CSV.open( "#{Rails.root}/etl/#{filename}", 'w' ) do |row|
      row << output_fields

      @events['events'].each do |event|

        event['headliners'].each do |e| 
          event['eventDescription'] = e['eventDescription']
        end

        event['venue_id'] = @venue_id

        sorted_event = []
      
        input_fields.each do |field|
          sorted_event << event[field]
        end

        row << sorted_event

      end
    end
    
    file = Send_to_s3.new('events_ticketfly_csv', filename)

  end
end


ticketfly_venues = []

ticketfly_venues << Venue.find(1)
ticketfly_venues  << Venue.find(3)

ticketfly_venues.each do |venue|
  if (venue.remote_id?)
    venue.name = Feed.new(TICKETFLY_URI, venue.remote_id, venue.id)
  end
end







