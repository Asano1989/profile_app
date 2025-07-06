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

ActiveRecord::Schema[7.2].define(version: 2025_07_05_133130) do
  create_table "profiles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "profile_image"
    t.string "nickname"
    t.string "sns_x_id"
    t.string "sns_instagram_id"
    t.string "sns_facebook_id"
    t.integer "birth_month"
    t.integer "birth_day"
    t.string "constellation"
    t.string "birthplace"
    t.string "personality_main"
    t.string "personality_sub"
    t.string "evaluation_others"
    t.string "hobby_or_interest"
    t.string "favorite_food"
    t.string "favorite_drink"
    t.string "favorite_artist"
    t.string "favorite_book"
    t.string "favorite_movie"
    t.string "favorite_anime_game"
    t.string "favorite_place"
    t.string "special_skill"
    t.string "things_i_want"
    t.string "future_dream"
    t.string "motto"
    t.text "free_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "public_uid"
    t.bigint "user_id"
    t.index ["public_uid"], name: "index_profiles_on_public_uid", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "profiles", "users"
end
