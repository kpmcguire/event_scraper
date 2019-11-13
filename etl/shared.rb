require_relative '../config/environment'
require 'httparty'

def consolidate_state_theatre_events
  dsp_prefix = 'State Theatre of Ithaca - DSP'.downcase

  dsp_state = Venue.where('lower(name) = ?', "#{dsp_prefix}")

  real_prefix = 'State Theatre of Ithaca'.downcase
  real_state = Venue.where('lower(name) = ?', "#{real_prefix}")

  dsp_events = Event.where(venue_id: dsp_state)
  real_state_events = Event.where(venue_id: real_state)
  real_state_event_id = real_state_events.pluck(:venue_id).first 

  dsp_events.update_all(venue_id: real_state_event_id)
  
end

consolidate_state_theatre_events