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

ActiveRecord::Schema.define(version: 20150422020619) do

  create_table "downvotes", force: true do |t|
    t.integer "user_id"
    t.integer "song_id"
  end

  add_index "downvotes", ["song_id"], name: "index_downvotes_on_song_id"
  add_index "downvotes", ["user_id"], name: "index_downvotes_on_user_id"

  create_table "reviews", force: true do |t|
    t.integer  "song_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating"
  end

  add_index "reviews", ["song_id"], name: "index_reviews_on_song_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "songs", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "songs", ["user_id"], name: "index_songs_on_user_id"

  create_table "upvotes", force: true do |t|
    t.integer "user_id"
    t.integer "song_id"
  end

  add_index "upvotes", ["song_id"], name: "index_upvotes_on_song_id"
  add_index "upvotes", ["user_id"], name: "index_upvotes_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
