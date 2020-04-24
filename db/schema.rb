# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_24_204954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.integer "mtnproj_id"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_areas_on_parent_id"
  end

  create_table "climbs", force: :cascade do |t|
    t.bigint "area_id", null: false
    t.string "name"
    t.string "location_str"
    t.string "mtnproj_id"
    t.integer "stars"
    t.string "key_type"
    t.string "full_type"
    t.string "rating"
    t.integer "numeric_rating"
    t.integer "pitches"
    t.float "lon"
    t.float "lat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "area_array", default: [], array: true
    t.index ["area_id"], name: "index_climbs_on_area_id"
  end

  create_table "user_climbs", force: :cascade do |t|
    t.bigint "climb_id", null: false
    t.bigint "user_id", null: false
    t.integer "pitches"
    t.date "start_date"
    t.date "end_date"
    t.string "style"
    t.string "led_pitches"
    t.string "outcome"
    t.boolean "highlight"
    t.string "partners"
    t.string "rack"
    t.string "beta"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["climb_id"], name: "index_user_climbs_on_climb_id"
    t.index ["user_id"], name: "index_user_climbs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "avatar"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "climbs", "areas"
  add_foreign_key "user_climbs", "climbs"
  add_foreign_key "user_climbs", "users"
end
