require_relative 'shared'

consolidate_state_theatre_events

def delete_old_events

  @old_events = Event.where(:start_time => 6.months.ago..1.months.ago)
  @empty_venues = Venue.left_outer_joins(:events).where(events: {id: nil})

  @old_events.destroy_all
  @empty_venues.destroy_all
end

delete_old_events