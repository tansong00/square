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

ActiveRecord::Schema.define(version: 20131115081610) do

  create_table "albums", force: true do |t|
    t.string   "title"
    t.string   "sku"
    t.string   "cover"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "pictures", force: true do |t|
    t.integer  "album_id"
    t.string   "file_name"
    t.string   "path"
    t.string   "file"
    t.boolean  "file_processing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_albums", force: true do |t|
    t.integer  "task_id"
    t.integer  "album_id"
    t.text     "pic_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.integer  "for_id"
    t.integer  "creator_id"
    t.datetime "closed_at"
    t.datetime "published_at"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
