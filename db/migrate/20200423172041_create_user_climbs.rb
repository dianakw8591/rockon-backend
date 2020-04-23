class CreateUserClimbs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_climbs do |t|
      t.references :climb, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :pitches
      t.date :start_date
      t.date :end_date
      t.string :style
      t.string :led_pitches
      t.string :outcome
      t.boolean :highlight
      t.string :partners
      t.string :rack
      t.string :beta
      t.string :notes

      t.timestamps
    end
  end
end
