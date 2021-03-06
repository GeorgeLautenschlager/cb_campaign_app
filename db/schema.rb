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

ActiveRecord::Schema[7.0].define(version: 2022_06_14_022429) do
  create_table "airforces", force: :cascade do |t|
    t.string "name"
    t.string "coalition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "airforces_card_templates", id: false, force: :cascade do |t|
    t.integer "airforce_id", null: false
    t.integer "card_template_id", null: false
  end

  create_table "card_templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "coalition"
    t.string "airforce"
    t.string "title"
    t.string "mission_description_text"
    t.string "flavour_text"
    t.string "targets"
    t.string "target_values"
    t.string "airfield"
    t.string "plane"
    t.integer "loadout"
    t.integer "death_percentage"
    t.integer "capture_percentage"
    t.string "area_of_operation"
    t.string "always_in_hand"
    t.integer "weight"
    t.string "defend"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "card_template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "coalition"
    t.string "airforce"
    t.string "title"
    t.string "mission_description_text"
    t.string "flavour_text"
    t.string "targets"
    t.string "target_values"
    t.string "airfield"
    t.string "plane"
    t.integer "loadout"
    t.integer "death_percentage"
    t.integer "capture_percentage"
    t.string "area_of_operation"
    t.boolean "active"
  end

  create_table "cards_pilots", id: false, force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "pilot_id"
    t.index ["card_id"], name: "index_cards_pilots_on_card_id"
    t.index ["pilot_id"], name: "index_cards_pilots_on_pilot_id"
  end

  create_table "mission_tracks", force: :cascade do |t|
    t.integer "card_id"
    t.integer "bot_pilot_id"
    t.string "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bot_pilot_id"], name: "index_mission_tracks_on_bot_pilot_id"
  end

  create_table "pilots", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "user_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pilots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
