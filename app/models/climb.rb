class Climb < ApplicationRecord
  belongs_to :area
  has_many :user_climbs

  validates :mtnproj_id, uniqueness: true
end
