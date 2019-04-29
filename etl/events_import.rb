require_relative '../config/environment'

require 'csv'

Dir.glob(["events_localist_csv/*.csv", "events_ticketfly_csv/*.csv"]).each do |file|
  CSV.foreach(file, headers: true) do |row|
    events_hash = row.to_hash 
    event = Event.where(name: events_hash["remote_id"])

    if event.count == 1
      event.first.update_attributes(events_hash)
    else
      Event.create!(events_hash)
    end 
  end 
end