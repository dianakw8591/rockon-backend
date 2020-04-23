class User < ApplicationRecord
  has_many :user_climbs
  has_many :climbs, -> { distinct }, through: :user_climbs
  has_many :areas, -> { distinct }, through: :climbs
end
