class User < ApplicationRecord
  has_many :user_climbs
  has_many :climbs, through: :user_climbs, uniq: :true
  has_many :locations, through: climbs, uniq: :true
end
