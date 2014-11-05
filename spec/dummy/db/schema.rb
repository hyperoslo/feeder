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

ActiveRecord::Schema.define(version: 20141105063221) do

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
    t.boolean  "sticky",                  default: false, null: false
    t.boolean  "blocked",                 default: false, null: false
    t.boolean  "recommended",             default: false, null: false
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.datetime "unpublished_at"
  end

  add_index "feeder_items", ["cached_votes_down"], name: "index_feeder_items_on_cached_votes_down"
  add_index "feeder_items", ["cached_votes_score"], name: "index_feeder_items_on_cached_votes_score"
  add_index "feeder_items", ["cached_votes_total"], name: "index_feeder_items_on_cached_votes_total"
  add_index "feeder_items", ["cached_votes_up"], name: "index_feeder_items_on_cached_votes_up"
  add_index "feeder_items", ["cached_weighted_average"], name: "index_feeder_items_on_cached_weighted_average"
  add_index "feeder_items", ["cached_weighted_score"], name: "index_feeder_items_on_cached_weighted_score"
  add_index "feeder_items", ["cached_weighted_total"], name: "index_feeder_items_on_cached_weighted_total"
  add_index "feeder_items", ["feedable_id", "feedable_type"], name: "index_feeder_items_on_feedable_id_and_feedable_type"

  create_table "feeder_reports", force: true do |t|
    t.integer  "reporter_id"
    t.string   "reporter_type"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "handled_at"
  end

  add_index "feeder_reports", ["item_id"], name: "index_feeder_reports_on_item_id"
  add_index "feeder_reports", ["reporter_id", "reporter_type"], name: "index_feeder_reports_on_reporter_id_and_reporter_type"

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
