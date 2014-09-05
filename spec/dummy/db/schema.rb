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

ActiveRecord::Schema.define(version: 20140815105053) do

  create_table "articles", force: true do |t|
    t.string   "header"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeder_items", force: true do |t|
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feedable_id"
    t.string   "feedable_type"
    t.boolean  "sticky",        default: false, null: false
    t.boolean  "blocked",       default: false, null: false
    t.boolean  "reported",      default: false, null: false
    t.boolean  "recommended",   default: false, null: false
  end

  add_index "feeder_items", ["feedable_id", "feedable_type"], name: "index_feeder_items_on_feedable_id_and_feedable_type"

  create_table "messages", force: true do |t|
    t.string   "header"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
