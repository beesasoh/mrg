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

ActiveRecord::Schema.define(:version => 20130710112349) do

  create_table "authors", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "email",      :limit => 100
    t.text     "bio"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.integer  "subject_id"
    t.text     "description"
    t.text     "content"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "book_file_file_name"
    t.string   "book_file_content_type"
    t.integer  "book_file_file_size"
    t.datetime "book_file_updated_at"
  end

  add_index "books", ["author_id"], :name => "index_books_on_author_id"
  add_index "books", ["subject_id"], :name => "index_books_on_subject_id"

  create_table "choices", :force => true do |t|
    t.integer  "question_id"
    t.string   "choice"
    t.boolean  "correct",     :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "choices", ["question_id"], :name => "index_choices_on_question_id"

  create_table "courses", :force => true do |t|
    t.integer  "author_id"
    t.integer  "subject_id"
    t.string   "title",      :limit => 100
    t.boolean  "published",                 :default => false
    t.integer  "level"
    t.integer  "cost"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "courses", ["author_id"], :name => "index_courses_on_author_id"
  add_index "courses", ["subject_id"], :name => "index_courses_on_subject_id"

  create_table "courses_users", :force => true do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["user_id", "course_id"], :name => "index_courses_users_on_user_id_and_course_id"

  create_table "questions", :force => true do |t|
    t.integer  "course_id"
    t.text     "question"
    t.text     "explanation"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "questions", ["course_id"], :name => "index_questions_on_course_id"

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
