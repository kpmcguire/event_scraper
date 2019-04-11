class Organization < ApplicationRecord
  has_many :events
  scope :sorted, lambda { order("name ASC") }

  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  def should_generate_new_friendly_id?
    name_changed?
  end

  def slug_candidates
    [
      :name,
      [:name, "#{Organization.where(name: name).count + 1}"]
    ]
  end  

end
