class ClimbSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_str, :mtnproj_id, :stars, :key_type, :full_type, :rating, :numeric_rating, :pitches, :lon, :lat, :area_array
  has_one :area_id
end
