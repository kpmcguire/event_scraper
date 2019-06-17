class Venue < ApplicationRecord
  has_many :events
  has_many :organizations, :through => :events
  has_one :source
  geocoded_by :address
  after_validation :geocode, :unless => :latitude?

  scope :sorted, lambda { order("name ASC") }

  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates
    [
      :name,
      [:name, "#{Venue.where(name: name).count + 1}"]
    ]
  end

  def self.search(search)
    if search
      Venue.where('LOWER(name) LIKE :q or LOWER(description) LIKE :q', q: "%#{search.downcase}%")
    else
      Venue.none
    end
  end  

end
