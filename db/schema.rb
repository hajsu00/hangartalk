# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_03_060611) do

  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aeroplane_flights", charset: "utf8mb3", force: :cascade do |t|
    t.integer "log_number"
    t.date "departure_date"
    t.string "aeroplane_type"
    t.string "aeroplane_ident"
    t.string "departure_point"
    t.string "arrival_point"
    t.string "exercises_or_maneuvers"
    t.integer "number_of_takeoff"
    t.integer "number_of_landing"
    t.datetime "moving_time"
    t.datetime "stop_time"
    t.boolean "is_pic"
    t.boolean "is_dual"
    t.boolean "is_cross_country"
    t.boolean "is_night_flight"
    t.boolean "is_hood"
    t.boolean "is_instrument"
    t.boolean "is_simulator"
    t.boolean "is_instructor"
    t.boolean "is_stall_recovery"
    t.boolean "close_log"
    t.string "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_aeroplane_flights_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_aeroplane_flights_on_user_id"
  end

  create_table "aeroplane_initial_logs", charset: "utf8mb3", force: :cascade do |t|
    t.integer "total_flight_number"
    t.integer "number_of_takeoff"
    t.integer "number_of_landing"
    t.integer "total_time"
    t.integer "pic_time"
    t.integer "solo_time"
    t.integer "cross_country_time"
    t.integer "night_time"
    t.integer "dual_time"
    t.integer "dual_crosss_country_time"
    t.integer "dual_night_time"
    t.integer "hood_time"
    t.integer "instrument_time"
    t.integer "simulator_time"
    t.integer "instructor_time"
    t.integer "number_of_stall_recovery"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_aeroplane_initial_logs_on_user_id"
  end

  create_table "glider_flights", charset: "utf8mb3", force: :cascade do |t|
    t.integer "log_number"
    t.date "departure_date"
    t.string "glider_type"
    t.string "glider_ident"
    t.string "departure_point"
    t.string "arrival_point"
    t.integer "number_of_landing"
    t.datetime "takeoff_time"
    t.datetime "landing_time"
    t.boolean "is_pic"
    t.boolean "is_dual"
    t.boolean "is_motor_glider"
    t.boolean "is_power_flight"
    t.boolean "is_winch"
    t.boolean "is_cross_country"
    t.string "release_alt"
    t.boolean "is_instructor"
    t.boolean "is_stall_recovery"
    t.boolean "close_log"
    t.string "note"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_glider_flights_on_user_id"
  end

  create_table "glider_group_flights", charset: "utf8mb3", force: :cascade do |t|
    t.integer "day_flight_number"
    t.date "date"
    t.string "place"
    t.string "way_of_towing"
    t.string "fleet"
    t.string "front_seat"
    t.string "front_seat_attribute"
    t.string "rear_seat"
    t.string "rear_seat_attribute"
    t.datetime "takeoff_time"
    t.datetime "release_time"
    t.datetime "landing_time"
    t.integer "release_alt"
    t.string "creator"
    t.string "updater"
    t.string "notes"
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_glider_group_flights_on_group_id"
  end

  create_table "glider_initial_logs", charset: "utf8mb3", force: :cascade do |t|
    t.integer "non_power_total_time"
    t.integer "non_power_total_number"
    t.integer "pic_winch_time"
    t.integer "pic_winch_number"
    t.integer "pic_aero_tow_time"
    t.integer "pic_aero_tow_number"
    t.integer "solo_winch_time"
    t.integer "solo_winch_number"
    t.integer "solo_aero_tow_time"
    t.integer "solo_aero_tow_number"
    t.integer "dual_winch_time"
    t.integer "dual_winch_number"
    t.integer "dual_aero_tow_time"
    t.integer "dual_aero_tow_number"
    t.integer "power_total_time"
    t.integer "power_total_number"
    t.integer "pic_power_time"
    t.integer "pic_power_number"
    t.integer "pic_power_off_time"
    t.integer "pic_power_off_number"
    t.integer "solo_power_time"
    t.integer "solo_power_number"
    t.integer "solo_power_off_time"
    t.integer "solo_power_off_number"
    t.integer "dual_power_time"
    t.integer "dual_power_number"
    t.integer "dual_power_off_time"
    t.integer "dual_power_off_number"
    t.integer "cross_country_time"
    t.integer "instructor_time"
    t.integer "instructor_number"
    t.integer "number_of_stall_recovery"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_glider_initial_logs_on_user_id"
  end

  create_table "group_users", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.text "introduction"
    t.string "privacy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "microposts", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "relationships", charset: "utf8mb3", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aeroplane_flights", "users"
  add_foreign_key "aeroplane_initial_logs", "users"
  add_foreign_key "glider_flights", "users"
  add_foreign_key "glider_group_flights", "groups"
  add_foreign_key "glider_initial_logs", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "microposts", "users"
end
