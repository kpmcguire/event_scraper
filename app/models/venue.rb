class Venue < ApplicationRecord
  has_many :events
  has_many :organizations, :through => :events
  geocoded_by :address
  after_validation :geocode

  scope :sorted, lambda { order("name ASC") }
end
