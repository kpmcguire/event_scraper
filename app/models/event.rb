class Event < ApplicationRecord

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