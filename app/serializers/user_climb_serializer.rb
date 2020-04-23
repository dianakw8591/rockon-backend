class UserClimbSerializer < ActiveModel::Serializer
  attributes :id, :pitches, :start_date, :end_date, :style, :led_pitches, :outcome, :highlight, :partners, :rack, :beta, :notes
  has_one :climb_id
  has_one :user_id
end
