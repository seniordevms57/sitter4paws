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

ActiveRecord::Schema[7.0].define(version: 2024_03_25_023752) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emergencies", force: :cascade do |t|
    t.string "fullname"
    t.string "phone_number"
    t.string "vet_fullname"
    t.string "vet_phone_number"
    t.string "vet_street"
    t.string "vet_apt_unit"
    t.string "vet_city"
    t.string "vet_state"
    t.string "vet_zip"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "pet_type"
    t.string "breed"
    t.string "color"
    t.string "gender"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aggression"
    t.datetime "birthday"
  end

  create_table "service_areas", force: :cascade do |t|
    t.string "name"
    t.string "towns"
    t.string "zip_codes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_service_areas_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "service"
    t.string "datetime"
    t.string "discount_code"
    t.string "comments"
    t.string "signature"
    t.string "heard_about_us"
    t.boolean "wants_virtual_consultation"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "agree_policy"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "password_digest"
    t.date "confirmed_at"
    t.string "verification_token"
    t.boolean "add_someone"
    t.boolean "phone_optin"
    t.boolean "phone_updates_consent_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "address"
    t.string "spouse_othername"
    t.string "from"
  end

  add_foreign_key "service_areas", "users"
end
