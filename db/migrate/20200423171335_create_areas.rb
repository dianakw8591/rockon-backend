class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :mtnproj_id
      t.references :parent_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
