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

  def rating
    venue_rating = self.venue.try(:rating) ? self.venue.rating : 0
    org_rating = self.organization.try(:rating) ? self.organization.rating : 0

    self.rating = venue_rating + org_rating
  end  

  def featured_events
    rating > -1
  end

  def self.search(search)
    if search
      Event.where('LOWER(name) LIKE :q or LOWER(description) LIKE :q', q: "%#{search.downcase}%")
    else
      Event.none
    end
  end

end