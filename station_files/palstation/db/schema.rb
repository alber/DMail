# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_27_194318) do

  create_table "flightplans", force: :cascade do |t|
    t.datetime "updated_at", null: false
    t.integer "updated_by"
    t.string "updated_by_me"
    t.integer "waypoint_count"
    t.integer "last_waypoint"
    t.integer "step_waypoint"
    t.datetime "created_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "author"
    t.datetime "authored"
    t.integer "authored_at"
    t.string "format"
    t.text "body"
    t.binary "data"
    t.integer "received_at"
    t.integer "received_by"
    t.string "received_by_me"
    t.boolean "is_received"
    t.boolean "is_sent"
    t.integer "jump"
    t.integer "destination_id"
    t.integer "final_destination_id"
    t.text "manifest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pals", force: :cascade do |t|
    t.string "status"
    t.string "location"
    t.float "lat"
    t.float "long"
    t.integer "payload_id"
    t.integer "flightplan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flightplan_id"], name: "index_pals_on_flightplan_id"
    t.index ["payload_id"], name: "index_pals_on_payload_id"
  end

  create_table "payloads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_sent"
    t.boolean "is_received"
    t.integer "pal_id"
    t.datetime "updated_at", null: false
    t.index ["pal_id"], name: "index_payloads_on_pal_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.string "admin"
    t.string "location"
    t.float "lat"
    t.float "long"
    t.integer "parent_id"
    t.string "status"
    t.integer "service_away_id"
    t.integer "service_home_id"
    t.integer "total"
    t.boolean "is_docked"
    t.integer "docked_id"
    t.integer "tier"
    t.integer "current_weatherscore"
    t.boolean "is_me"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waypoints", force: :cascade do |t|
    t.float "lat"
    t.float "long"
    t.integer "step"
    t.integer "flightplan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flightplan_id"], name: "index_waypoints_on_flightplan_id"
  end

  create_table "weathers", force: :cascade do |t|
    t.integer "station_id"
    t.float "score"
    t.text "description"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.index ["station_id"], name: "index_weathers_on_station_id"
  end

end
