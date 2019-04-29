require 'csv'
require 'faraday'

namespace :import_csv do

  task :events => :environment do 
    CSV.foreach('tmp/events-import.csv', headers: true) do |row|
      event_hash = row.to_hash 
      event = Event.where(name: event_hash["name"])

      if event.count == 1
        event.first.update_attributes(event_hash)
      else
        Event.create!(event_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end
end
