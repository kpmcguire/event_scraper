require_relative 'shared'

ic_org_pholder = {name: 'Ithaca College', address:'953 Danby Road Ithaca, NY 14850',rating: -10}
cornell_org_pholder = {name: 'Cornell University', address: '144 East Ave., Ithaca, NY 14853', rating: -10}
vi_org_pholder = {name: 'Visit Ithaca', address: 'Ithaca, NY 14850', rating: 0}


Organization.where(ic_org_pholder).first_or_create(ic_org_pholder)
Organization.where(cornell_org_pholder).first_or_create(cornell_org_pholder)
Organization.where(vi_org_pholder).first_or_create(vi_org_pholder)

ITHACA_ORG = Organization.where(ic_org_pholder).pluck(:id).first
CORNELL_ORG = Organization.where(cornell_org_pholder).pluck(:id).first
VISITITHACA_ORG = Organization.where(vi_org_pholder).pluck(:id).first

ITHACA_LOCALIST_URI = "https://events.ithaca.edu/api/2/events"
CORNELL_LOCALIST_URI = "https://events.cornell.edu/api/2/events"
VISITITHACA_LOCALIST_URI = "https://events.visitithaca.com/api/2/events"

class Feed
   
  def initialize(uri, org)    
    
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

          if e['event']['location_name']
            venue_pholder[:name] = e['event']['location_name']
          else
            venue_pholder[:name] = e['event']['address']
          end

          venue_pholder[:address] = e['event']['address']
          Venue.where(name: venue_pholder[:name]).first_or_create(venue_pholder).update(venue_pholder)
          local_venue_id = Venue.where(venue_pholder).pluck(:id).first
          
          e['event']['venue_id'] = local_venue_id
        end

        pholder = e['event'].select { |k, v| input_fields.include? k }

        pholder.keys.each { |k| pholder[ mappings[k] ] = pholder.delete(k) if mappings[k] }

        pholder['organization_id'] = org

        event_query = pholder['name']
        Event.where('lower(name) = ?', event_query.downcase).first_or_create(pholder).update(pholder)   
      
      end        

      sleep 10
    end
  end
end

ithaca_college = Feed.new(ITHACA_LOCALIST_URI, ITHACA_ORG)
cornell_university = Feed.new(CORNELL_LOCALIST_URI, CORNELL_ORG)
visit_ithaca = Feed.new(VISITITHACA_LOCALIST_URI, VISITITHACA_ORG)

consolidate_state_theatre_events