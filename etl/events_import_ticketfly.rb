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
    process_events

  end

  def process_events
    input_fields = ['venue_id', 'id', 'name', 'ticketPurchaseUrl', 'ticketPrice', 'doorsDate', 'eventDescription']

    mappings = {
      "venue_id" => "venue_id", 
      "id" => "remote_id",
      "name" => "name", 
      "ticketPurchaseUrl" => "url",
      "ticketPrice" => "cost",
      "doorsDate" => "start_time",
      "eventDescription" => "description",
    }
        
    @events['events'].each do |e|

      e['headliners'].each do |ev| 
        e['eventDescription'] = ev['eventDescription']
      end

      pholder = e.select { |k, v|  input_fields.include? k }

      pholder.keys.each { |k| pholder[ mappings[k] ] = pholder.delete(k) if mappings[k] }

      pholder['venue_id'] = @venue_id

      if @venue_remote_id == 13897
        org = Organization.find_by(name: 'The Haunt')
        pholder['organization_id'] = org.id
      elsif @venue_remote_id == 3273
        org = Organization.find_by(name: 'State Theatre')
        pholder['organization_id'] = org.id
      end

      Event.where(remote_id: pholder['remote_id']).first_or_create(pholder)

    end
  end
end


ticketfly_venues = []

ticketfly_venues << Venue.find_by(remote_id: 13897) # the haunt
ticketfly_venues << Venue.find_by(remote_id: 3273) #state theater

ticketfly_venues.each do |venue|
  if (venue.remote_id?)
    venue.name = Feed.new(TICKETFLY_URI, venue.remote_id, venue.id)
  end
end
