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

ActiveRecord::Schema.define(version: 20140301214749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",  default: false, null: false
  end

  add_index "articles", ["published"], name: "index_articles_on_published", using: :btree
  add_index "articles", ["user_id"], name: "index_articles_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content",          null: false
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "follows", force: true do |t|
    t.integer  "followable_id"
    t.string   "followable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id"], name: "index_follows_on_followable_id", using: :btree
  add_index "follows", ["followable_type"], name: "index_follows_on_followable_type", using: :btree
  add_index "follows", ["user_id"], name: "index_follows_on_user_id", using: :btree

  create_table "links", force: true do |t|
    t.integer  "user_id",                null: false
    t.text     "url",                    null: false
    t.text     "name",                   null: false
    t.integer  "score",        limit: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating_score", limit: 8, null: false
  end

  create_table "notifications", force: true do |t|
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",        default: false, null: false
    t.string   "action",                      null: false
    t.boolean  "emailed",     default: false, null: false
  end

  add_index "notifications", ["read"], name: "index_notifications_on_read", using: :btree
  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id", using: :btree
  add_index "notifications", ["target_id"], name: "index_notifications_on_target_id", using: :btree
  add_index "notifications", ["target_type"], name: "index_notifications_on_target_type", using: :btree

  create_table "projects", force: true do |t|
    t.text     "name"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "details"
    t.text     "homepage"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", using: :btree
  add_index "projects", ["summary"], name: "index_projects_on_summary", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.boolean  "positive"
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["positive"], name: "index_ratings_on_positive", using: :btree
  add_index "ratings", ["ratable_type", "ratable_id"], name: "index_ratings_on_ratable_type_and_ratable_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "updates", force: true do |t|
    t.integer  "updateable_id"
    t.string   "updateable_type"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "updates", ["updateable_id"], name: "index_updates_on_updateable_id", using: :btree
  add_index "updates", ["updateable_type"], name: "index_updates_on_updateable_type", using: :btree

  create_table "user_projects", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_projects", ["project_id"], name: "index_user_projects_on_project_id", using: :btree
  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                            null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
