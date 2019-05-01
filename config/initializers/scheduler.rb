require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.at 'every monday and wednesday and friday at 4:00am' do
  system("ruby etl/events_ticketfly.rb")
end

s.at 'every monday and wednesday and friday at 4:30am' do
  system("ruby etl/events_localist.rb")
end

s.at 'every tuesday and thursday and saturday at 4:00am' do
  system("ruby etl/events_import.rb")
end

s.at 'every saturday at 5:00am' do
  system("ruby etl/venues_localist_csv.rb")
end

s.at 'every sunday at 4:00am' do
  system("ruby etl/venues_import.rb")
end