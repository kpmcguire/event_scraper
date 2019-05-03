require_relative 'shared'

ITHACA_LOCALIST_URI = "https://events.ithaca.edu/api/2/places"
CORNELL_LOCALIST_URI = "https://events.cornell.edu/api/2/places"
VISITITHACA_LOCALIST_URI = "https://events.visitithaca.com/api/2/places"

class Feed

  def initialize(uri, filename)    
    
    @pages = HTTParty.get(uri, :query => {'page' => 1 }, :headers => {"User-Agent" => "Safari"}, :verify => false)

    @pages = @pages['page']

    sorted_place = []

    timestamp = Time.now.strftime("%Y%m%dT%H%M%S")
    filename = "#{filename}.csv"

    input_fields = ['id', 'display_name', 'localist_url', 'address', 'latitude', 'longitude']
    output_fields = ['remote_id', 'name', 'url', 'address', 'latitude', 'longitude']

    for i in @pages['current']..@pages['total']
    # for i in @pages['current']..1
      @response = HTTParty.get(uri, :query => {'page' => i}, :headers => {"User-Agent" => "Safari"}, :verify => false)

      @response['places'].each do |place|
        row = []

        place['place']['latitude'] = place['place']['geo']['latitude']
        place['place']['longitude'] = place['place']['geo']['longitude']


        input_fields.each do |field|
          row << place['place'][field]
        end
        sorted_place << row
      end        

      sleep 10
    end

    CSV.open( filename, 'w' ) do |row|
      row << output_fields

      sorted_place.each do |place|
        row << place
      end
    end

    file = Send_to_s3.new('venues_csv', filename)

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
