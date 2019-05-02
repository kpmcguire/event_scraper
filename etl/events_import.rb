require_relative 'shared'

Dir.glob(["events_localist_csv/*.csv", "events_ticketfly_csv/*.csv"]).each do |file|
  CSV.foreach(file, headers: true) do |row|
    events_hash = row.to_hash 
    Event.where(name: events_hash['name'], start_time: events_hash['start_time']).first_or_create(events_hash)
  end 
end