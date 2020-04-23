class AreaSerializer < ActiveModel::Serializer
  attributes :id, :name, :mtnproj_id
  has_one :parent_id
end
