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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130702071901) do

  create_table "authors", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "email",      :limit => 100
    t.text     "bio"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "courses", :force => true do |t|
    t.integer  "author_id"
    t.integer  "subject_id"
    t.string   "title",         :limit => 100
    t.integer  "num_questions"
    t.integer  "level"
    t.integer  "cost"
    t.text     "questions"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "courses", ["author_id"], :name => "index_courses_on_author_id"
  add_index "courses", ["subject_id"], :name => "index_courses_on_subject_id"

  create_table "courses_users", :force => true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id"

  create_table "subjects", :force => true do |t|
    t.string   "name",                     :limit => 100
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "image_thumb_file_name"
    t.string   "image_thumb_content_type"
    t.integer  "image_thumb_file_size"
    t.datetime "image_thumb_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider",         :limit => 100
    t.string   "uid",              :limit => 100, :null => false
    t.string   "name",             :limit => 100, :null => false
    t.string   "email",            :limit => 100, :null => false
    t.string   "image"
    t.integer  "coins"
    t.integer  "level"
    t.string   "oauth_token",                     :null => false
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

end
