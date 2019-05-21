require_relative 'shared'

ITHACA_LOCALIST_URI = "https://events.ithaca.edu/api/2/places"
CORNELL_LOCALIST_URI = "https://events.cornell.edu/api/2/places"
VISITITHACA_LOCALIST_URI = "https://events.visitithaca.com/api/2/places"

class Feed

  def initialize(uri, filename)    
    
    @pages = HTTParty.get(uri, :query => {'page' => 1 }, :headers => {"User-Agent" => "Safari"}, :verify => false)

    @pages = @pages['page']

    input_fields = ['id', 'display_name', 'localist_url', 'address', 'latitude', 'longitude']

    mappings = {
      "id" => "remote_id", 
      "display_name" => "name",
      "localist_url" => "url", 
      "address" => "address",
      "latitude" => "latitude",
      "longitude" => "longitude"
    }

    for i in @pages['current']..@pages['total']
    # for i in @pages['current']..1
      @response = HTTParty.get(uri, :query => {'page' => i}, :headers => {"User-Agent" => "Safari"}, :verify => false)

      @response['places'].each do |place|

        place['place']['latitude'] = place['place']['geo']['latitude']
        place['place']['longitude'] = place['place']['geo']['longitude']

        pholder = place['place'].select { |k, v|  input_fields.include? k }

        pholder.keys.each { |k| pholder[ mappings[k] ] = pholder.delete(k) if mappings[k] }

        puts pholder

        Venue.where(remote_id: pholder['remote_id']).first_or_create(pholder)

      end        

      sleep 10
    end
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
