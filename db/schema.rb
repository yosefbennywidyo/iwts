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

ActiveRecord::Schema[7.0].define(version: 2023_01_22_060225) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stocks", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_stocks_on_code", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_teams_on_code", unique: true
  end

  create_table "transaction_histories", id: false, force: :cascade do |t|
    t.decimal "amount"
    t.string "type"
    t.string "owner_id"
    t.string "sender_id"
    t.string "receiver_id"
    t.string "number"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_users_on_code", unique: true
  end

  create_table "wallets", id: false, force: :cascade do |t|
    t.string "address"
    t.string "owner_id"
    t.decimal "balance", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
