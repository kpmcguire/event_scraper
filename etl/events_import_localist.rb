require_relative 'shared'

ITHACA_LOCALIST_URI = "https://events.ithaca.edu/api/2/events"
CORNELL_LOCALIST_URI = "https://events.cornell.edu/api/2/events"
VISITITHACA_LOCALIST_URI = "https://events.visitithaca.com/api/2/events"

class Feed
   
  def initialize(uri, orgstring)    
    
    @pages = HTTParty.get(uri, :query => {'page' => 1, 'days' => '370' }, :headers => {"User-Agent" => "Safari"}, :verify => false)

    @pages = @pages['page']

    input_fields = ['venue_id', 'id', 'title', 'localist_url', 'start', 'ticket_cost', 'description']

    for i in @pages['current']..@pages['total']
    # for i in @pages['current']..1
      @response = HTTParty.get(uri, :query => {'page' => i,'days' => '370' }, :headers => {"User-Agent" => "Safari"}, :verify => false)

      input_fields = ['venue_id', 'id', 'title', 'localist_url', 'start', 'ticket_cost', 'description']

      mappings = {
        "venue_id" => "venue_id", 
        "id" => "remote_id",
        "title" => "name", 
        "localist_url" => "url",
        "ticket_cost" => "cost",
        "start" => "start_time",
        "description" => "description",
      }

      @response['events'].each do |e|
        
        e['event']['event_instances'].each do |ev| 
          e['event']['start'] = ev['event_instance']['start']
        end      

        venue_id = e['event']['venue_id']

        if venue_id 
          local_venue_id = Venue.where(remote_id: venue_id).pluck(:id).first
          e['event']['venue_id'] = local_venue_id          
        else
          venue_pholder = {}
          venue_pholder[:name] = e['event']['location_name']
          venue_pholder[:address] = e['event']['address']
          Venue.where(name: e['event']['location_name']).first_or_create(venue_pholder).update(venue_pholder)
        end

        pholder = e['event'].select { |k, v| input_fields.include? k }

        pholder.keys.each { |k| pholder[ mappings[k] ] = pholder.delete(k) if mappings[k] }

        if orgstring == 'localist-ithaca'
          org = Organization.find_by(name: 'Ithaca College')
          pholder['organization_id'] = org.id

        elsif orgstring == 'localist-cornell'
          org = Organization.find_by(name: 'Cornell University')
          pholder['organization_id'] = org.id

        elsif orgstring == 'localist-visitithaca'
          org = Organization.find_by(name: 'Visit Ithaca')
          pholder['organization_id'] = org.id
        end

        Event.where(remote_id: pholder['remote_id']).first_or_create(pholder).update(pholder)   

      end        

      sleep 10
    end
  end
end

ithaca_college = Feed.new(ITHACA_LOCALIST_URI, 'localist-ithaca')
cornell_university = Feed.new(CORNELL_LOCALIST_URI, 'localist-cornell')
visit_ithaca = Feed.new(VISITITHACA_LOCALIST_URI, 'localist-visitithaca')