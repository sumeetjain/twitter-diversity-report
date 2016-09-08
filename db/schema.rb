# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160907200202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ethnicities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ethnicities", ["user_id"], name: "index_ethnicities_on_user_id", using: :btree

  create_table "genders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "genders", ["user_id"], name: "index_genders_on_user_id", using: :btree

  create_table "orientations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orientations", ["user_id"], name: "index_orientations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "twitter_id", limit: 8
    t.integer  "age"
    t.integer  "income"
    t.string   "education"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_foreign_key "ethnicities", "users"
  add_foreign_key "genders", "users"
  add_foreign_key "orientations", "users"
end
