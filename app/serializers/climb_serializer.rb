class ClimbSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_str, :mtnproj_id, :stars, :type, :full_type, :rating, :numeric_rating, :pitches, :lon, :lat
  has_one :area_id
end
