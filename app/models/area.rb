class Area < ApplicationRecord
  has_many :children, class_name: "Area", foreign_key: :parent_id
  belongs_to :parent, class_name: "Area", optional: true
  has_many :climbs

  validates :mtnproj_id, uniqueness: true


  def all_child_routes
    routes = children.map { |area| area.all_child_routes }
    routes << climbs
    routes.flatten
  end
end
