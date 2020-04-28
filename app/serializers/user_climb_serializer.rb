class UserClimbSerializer < ActiveModel::Serializer
  attributes :id, :pitches, :start_date, :end_date, :style, :led_pitches, :outcome, :highlight, :partners, :rack, :beta, :notes, :climb
  def climb
    {
      climb_id: self.object.climb.id, 
      name: self.object.climb.name,
      full_type: self.object.climb.full_type,
      key_type: self.object.climb.key_type,
      rating: self.object.climb.rating,
      numeric_rating: self.object.climb.numeric_rating,
      area_array: self.object.climb.area_array
    }
  end 
end