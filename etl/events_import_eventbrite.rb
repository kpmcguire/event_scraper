require_relative 'shared'

org_pholder = {name: 'Eventbrite', rating: 10}
Organization.where(org_pholder).first_or_create(org_pholder)
EVENTBRITE_ORG = Organization.where(org_pholder).pluck(:id).first

EVENTBRITE_URI = "https://www.eventbriteapi.com/v3/events/search/"

class Feed
   
  def initialize(uri, org)    
    
    pages = HTTParty.get(uri, headers: {'Accept': 'application/json'}, query: { 'location.latitude': '42.44063', 'location.longitude': '-76.49661', 'location.within': '15mi', 'token': 'NBJREJLTQRWQ2YR3N2FK'})
    
    total_pages = pages['pagination']['page_count']

    # for i in 1..total_pages
    for i in 1..1

      response = HTTParty.get(uri, headers: {'Accept': 'application/json'}, query: { 'page': i, 'location.latitude': '42.44063', 'location.longitude': '-76.49661', 'location.within': '15mi', 'expand': 'venue,ticket_availability', 'token': 'NBJREJLTQRWQ2YR3N2FK'})

      response['events'].each do |e| 

        pholder = {}

        if e['venue_id']
          venue_pholder = {}
          venue_pholder[:name] = e['venue']['name']
          venue_pholder[:address] = e['venue']['localized_address_display']
          venue_pholder[:url] = e['venue']['resource_url']
          venue_pholder[:latitude] = e['venue']['latitude']
          venue_pholder[:longitude] = e['venue']['longitude']
          
          query = e['venue']['name']
          Venue.where('lower(name) = ?', query.downcase).first_or_create(venue_pholder).update(venue_pholder)
          the_venue = Venue.where(venue_pholder).pluck(:id).first

        end

        pholder['organization_id'] = org
        pholder['venue_id'] = the_venue
        pholder['remote_id'] = e['id']
        pholder['name'] = e['name']['text']
        pholder['description'] = e['description']['html']
        pholder['url'] = e['url']

        min_price = e['ticket_availability']['minimum_ticket_price']['display']
        max_price = e['ticket_availability']['maximum_ticket_price']['display']

        pholder['cost'] = "#{min_price} - #{max_price}"
        pholder['start_time'] = e['start']['local']

        sleep 10

        event_query = pholder['name']
        Event.where('lower(name) = ?', event_query.downcase).first_or_create(pholder).update(pholder)   

      end        
    end
  end
end

eventbrite = Feed.new(EVENTBRITE_URI, EVENTBRITE_ORG)
consolidate_state_theatre_events