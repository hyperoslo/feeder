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

ActiveRecord::Schema.define(version: 20141016065532) do

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

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
