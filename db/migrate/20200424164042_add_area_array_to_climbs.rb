class AddAreaArrayToClimbs < ActiveRecord::Migration[6.0]
  def change
    add_column :climbs, :area_array, :string, array:true, default: [] 
  end
end
