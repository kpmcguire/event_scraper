class Organization < ApplicationRecord
  has_many :events
  scope :sorted, lambda { order("name ASC") }
end
