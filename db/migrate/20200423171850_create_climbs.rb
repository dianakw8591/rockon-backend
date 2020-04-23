class CreateClimbs < ActiveRecord::Migration[6.0]
  def change
    create_table :climbs do |t|
      t.references :area, null: false, foreign_key: true
      t.string :name
      t.string :location_str
      t.string :mtnproj_id
      t.integer :stars
      t.string :type
      t.string :full_type
      t.string :rating
      t.integer :numeric_rating
      t.integer :pitches
      t.float :lon
      t.float :lat

      t.timestamps
    end
  end
end
