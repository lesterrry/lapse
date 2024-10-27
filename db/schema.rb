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

ActiveRecord::Schema[7.0].define(version: 2024_10_27_114539) do
  create_table "lifetimes", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lifetimes_on_user_id"
  end

  create_table "periods", force: :cascade do |t|
    t.integer "lifetime_id", null: false
    t.datetime "start"
    t.datetime "end"
    t.text "title"
    t.text "description"
    t.text "color_hex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lifetime_id"], name: "index_periods_on_lifetime_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "lifetimes", "users"
  add_foreign_key "periods", "lifetimes"
end
