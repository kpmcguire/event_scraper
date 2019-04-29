class Event < ApplicationRecord
  # require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      event_hash = row.to_hash 
      event = Event.where(remote_id: event_hash["remote_id"])

      if event.count == 1
        event.first.update_attributes(event_hash)
      else
        Event.create!(event_hash)
      end # end if !product.nil?
    end # end CSV.foreach
  end # end self.import(file)

  belongs_to :organization, optional: true
  belongs_to :venue, optional: true

  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates
    [
      :name,
      [:name, "#{Event.where(name: name).count + 1}"]
    ]
  end

end