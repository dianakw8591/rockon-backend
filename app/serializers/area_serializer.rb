class AreaSerializer < ActiveModel::Serializer
  attributes :id, :name, :parent

  def parent
    self.object.parent ? AreaSerializer.new(self.object.parent) : nil;
  end
end


