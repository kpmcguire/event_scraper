require_relative 'shared'

def reset_all
  Event.destroy_all
  Venue.destroy_all
  Organization.destroy_all

  require_relative 'venues_import_localist'
  require_relative 'events_import_localist'
  require_relative 'events_import_eventbrite'
  require_relative 'remove_old_data'

end

reset_all