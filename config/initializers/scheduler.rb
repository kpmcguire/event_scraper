# require 'rufus-scheduler'

# s = Rufus::Scheduler.singleton

# s.every '1m' do
#   system("rails import_csv:events")
#   Rails.logger.info "hello, I just imported some events"
#   Rails.logger.flush
# end