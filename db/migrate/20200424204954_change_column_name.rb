class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :climbs, :type, :key_type
  end
end
