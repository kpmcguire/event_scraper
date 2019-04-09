class Venue < ApplicationRecord
  has_many :events
  has_many :organizations, :through => :events

  scope :sorted, lambda { order("name ASC") }
end
