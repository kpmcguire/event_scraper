# require 'rufus-scheduler'
# require_relative '../../config/environment'

# s = Rufus::Scheduler.new

# s.every "10s" do
#   puts "ok"
#   sleep 12
#   puts "ko"
# end



# s.at 'every thursday at 12:46pm' do
#   puts 'getting from ticketfly'
#   system("ruby #{Rails.root}/etl/events_ticketfly_csv.rb")
#   puts 'getting from ticketfly is done'
# end

# s.at 'every monday and wednesday and friday at 4:00am' do
#   system("ruby #{Rails.root}/etl/events_ticketfly_csv.rb")
# end

# s.at 'every monday and wednesday and friday at 4:30am' do
#   system("ruby etl/events_localist_csv.rb")
# end

# s.at 'every tuesday and thursday and saturday at 4:00am' do
#   system("ruby etl/events_import.rb")
# end

# s.at 'every saturday at 5:00am' do
#   system("ruby etl/venues_localist_csv.rb")
# end

# s.at 'every sunday at 4:00am' do
#   system("ruby etl/venues_import.rb")
# end