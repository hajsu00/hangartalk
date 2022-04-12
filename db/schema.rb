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

ActiveRecord::Schema.define(version: 2022_03_10_013111) do

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
    t.date "date"
    t.string "aeroplane_type"
    t.string "aeroplane_ident"
    t.string "departure_point"
    t.string "arrival_point"
    t.string "exercises_or_maneuvers"
    t.integer "number_of_takeoff"
    t.integer "number_of_landing"
    t.datetime "moving_time"
    t.datetime "stop_time"
    t.string "flight_role"
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

  create_table "aircraft_types", charset: "utf8mb3", force: :cascade do |t|
    t.string "aircraft_type"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fleets", charset: "utf8mb3", force: :cascade do |t|
    t.string "ident"
    t.integer "aircraft_type_id"
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_fleets_on_group_id"
  end

  create_table "glider_flights", charset: "utf8mb3", force: :cascade do |t|
    t.integer "log_number"
    t.date "date"
    t.integer "glider_type"
    t.string "glider_ident"
    t.string "departure_and_arrival_point"
    t.integer "number_of_landing"
    t.datetime "takeoff_time"
    t.datetime "landing_time"
    t.string "flight_role"
    t.boolean "is_motor_glider"
    t.boolean "is_power_flight"
    t.boolean "is_winch"
    t.boolean "is_cross_country"
    t.integer "release_alt"
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
    t.string "departure_and_arrival_point"
    t.boolean "is_winch"
    t.integer "fleet"
    t.integer "front_seat"
    t.string "front_flight_role"
    t.integer "rear_seat"
    t.string "rear_flight_role"
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
    t.date "at_present"
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

  create_table "glider_micropost_relationships", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "micropost_id", null: false
    t.bigint "glider_flight_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["glider_flight_id"], name: "index_glider_micropost_relationships_on_glider_flight_id"
    t.index ["micropost_id"], name: "index_glider_micropost_relationships_on_micropost_id"
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

  create_table "like_relationships", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "micropost_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["micropost_id"], name: "index_like_relationships_on_micropost_id"
    t.index ["user_id", "micropost_id"], name: "index_like_relationships_on_user_id_and_micropost_id"
    t.index ["user_id"], name: "index_like_relationships_on_user_id"
  end

  create_table "microposts", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.boolean "is_flight_attached"
    t.boolean "is_sharing_micropost"
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

  create_table "reply_relationships", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "replying_id", null: false
    t.bigint "replied_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["replied_id"], name: "index_reply_relationships_on_replied_id"
    t.index ["replying_id", "replied_id"], name: "index_reply_relationships_on_replying_id_and_replied_id"
    t.index ["replying_id"], name: "index_reply_relationships_on_replying_id"
  end

  create_table "share_relationships", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "sharing_id", null: false
    t.bigint "shared_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shared_id"], name: "index_share_relationships_on_shared_id"
    t.index ["sharing_id", "shared_id"], name: "index_share_relationships_on_sharing_id_and_shared_id"
    t.index ["sharing_id"], name: "index_share_relationships_on_sharing_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "admin", default: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "introduction", default: ""
    t.string "location", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aeroplane_flights", "users"
  add_foreign_key "aeroplane_initial_logs", "users"
  add_foreign_key "fleets", "groups"
  add_foreign_key "glider_flights", "users"
  add_foreign_key "glider_group_flights", "groups"
  add_foreign_key "glider_initial_logs", "users"
  add_foreign_key "glider_micropost_relationships", "glider_flights"
  add_foreign_key "glider_micropost_relationships", "microposts"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "like_relationships", "microposts"
  add_foreign_key "like_relationships", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "reply_relationships", "microposts", column: "replied_id"
  add_foreign_key "reply_relationships", "microposts", column: "replying_id"
  add_foreign_key "share_relationships", "microposts", column: "shared_id"
  add_foreign_key "share_relationships", "microposts", column: "sharing_id"
end
