class ClimbSerializer < ActiveModel::Serializer
  attributes :id, :name, :mtnproj_id, :stars, :key_type, :full_type, :rating, :numeric_rating, :pitches, :area_array
  # has_one :area_id
  # :lon, :lat, :location_str,
end
