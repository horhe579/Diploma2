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

ActiveRecord::Schema[7.0].define(version: 2023_02_27_090955) do
  create_table "cards", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", null: false
    t.integer "damage", default: 0
    t.integer "shield", default: 0
    t.integer "draw", default: 0
    t.integer "play_again", default: 0
    t.integer "heal", default: 0
    t.string "image", default: "cards/sashostencil.png"
    t.string "back_of_card"
    t.index ["company_id"], name: "index_cards_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealts", force: :cascade do |t|
    t.integer "games_user_id", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_dealts_on_card_id"
    t.index ["games_user_id"], name: "index_dealts_on_games_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.boolean "rogue", default: true
    t.boolean "wizard", default: true
    t.boolean "paladin", default: true
    t.boolean "barbarian", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_selected_deck"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "games_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hp"
    t.integer "shield"
    t.index ["company_id"], name: "index_games_users_on_company_id"
    t.index ["game_id"], name: "index_games_users_on_game_id"
    t.index ["user_id"], name: "index_games_users_on_user_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "games_user_id", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_turns_on_card_id"
    t.index ["games_user_id"], name: "index_turns_on_games_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", default: 593363170, null: false
    t.string "username"
    t.integer "game_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "companies"
  add_foreign_key "dealts", "cards"
  add_foreign_key "dealts", "games_users"
  add_foreign_key "games", "users"
  add_foreign_key "games_users", "companies"
  add_foreign_key "games_users", "games"
  add_foreign_key "games_users", "users"
  add_foreign_key "turns", "cards"
  add_foreign_key "turns", "games_users"
  add_foreign_key "users", "companies"
end
