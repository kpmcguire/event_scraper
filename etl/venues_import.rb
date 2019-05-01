require_relative '../config/environment'

require 'csv'

Dir.glob("venues_csv/*.csv").each do |file|
  CSV.foreach(file, headers: true) do |row|
    venues_hash = row.to_hash 
    Venue.where(remote_id: venues_hash['remote_id']).first_or_create(venues_hash)
  end 
end