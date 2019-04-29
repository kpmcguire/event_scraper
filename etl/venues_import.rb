require_relative '../config/environment'

require 'csv'

Dir.glob("venues_csv/*.csv").each do |file|
  CSV.foreach(file, headers: true) do |row|
    venues_hash = row.to_hash 
    venue = Venue.where(name: venues_hash["remote_id"])

    if venue.count == 1
      venue.first.update_attributes(venues_hash)
    else
      Venue.create!(venues_hash)
    end 
  end 
end