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

ActiveRecord::Schema[7.0].define(version: 2023_11_08_192621) do
  create_table "custom_prices", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "price"
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_custom_prices_on_room_id"
  end

  create_table "guesthouses", force: :cascade do |t|
    t.string "description"
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.integer "payment_method_id", null: false
    t.boolean "pet_friendly"
    t.string "usage_policy"
    t.time "checkin"
    t.time "checkout"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "postal_code"
    t.integer "host_id", null: false
    t.index ["host_id"], name: "index_guesthouses_on_host_id"
    t.index ["payment_method_id"], name: "index_guesthouses_on_payment_method_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
    t.index ["reset_password_token"], name: "index_guests_on_reset_password_token", unique: true
  end

  create_table "hosts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_hosts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_hosts_on_reset_password_token", unique: true
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "size"
    t.string "max_people"
    t.boolean "bathroom"
    t.boolean "balcony"
    t.boolean "air_conditioner"
    t.boolean "tv"
    t.integer "guesthouse_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "wardrobe"
    t.boolean "safe"
    t.boolean "accessibility"
    t.integer "status", default: 0
    t.decimal "price"
    t.index ["guesthouse_id"], name: "index_rooms_on_guesthouse_id"
  end

  add_foreign_key "custom_prices", "rooms"
  add_foreign_key "guesthouses", "hosts"
  add_foreign_key "guesthouses", "payment_methods"
  add_foreign_key "rooms", "guesthouses"
end
