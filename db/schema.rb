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

ActiveRecord::Schema.define(:version => 20120112044300) do

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "synopsis"
    t.text     "body",         :limit => 16777215
    t.boolean  "published",                        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.string   "guest_name"
    t.string   "guest_email"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["entry_id"], :name => "index_comments_on_entry_id"

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "comments_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :default => 0,  :null => false
    t.string   "permalink",    :default => ""
  end

  create_table "funs", :force => true do |t|
    t.string   "title",       :default => "笑话", :null => false
    t.text     "body",                          :null => false
    t.integer  "click_time",  :default => 1008, :null => false
    t.string   "from_url"
    t.integer  "category_id", :default => 0,    :null => false
    t.integer  "user_id",     :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funs_copy", :force => true do |t|
    t.string   "title",       :default => "笑话", :null => false
    t.text     "body",                          :null => false
    t.integer  "click_time",  :default => 1008, :null => false
    t.string   "from_url"
    t.integer  "category_id", :default => 0,    :null => false
    t.integer  "user_id",     :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.integer  "category_id", :default => 4,     :null => false
    t.string   "name",        :default => "游戏",  :null => false
    t.string   "company"
    t.text     "synopsis"
    t.string   "logo"
    t.string   "ad_word"
    t.boolean  "is_new",      :default => false, :null => false
    t.boolean  "is_online",   :default => true,  :null => false
    t.boolean  "sales",       :default => false, :null => false
    t.string   "sale_url"
    t.integer  "user_id",     :default => 1,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hot_num",     :default => 0
    t.string   "permalink",   :default => ""
  end

  create_table "infoforzufang", :force => true do |t|
    t.text "title"
    t.text "pub_time"
    t.text "area"
    t.text "config"
    t.text "price"
    t.text "zhuangxiu"
    t.text "floor"
    t.text "pub_name"
    t.text "tel"
    t.text "intor"
    t.text "address"
    t.text "style"
  end

  create_table "infos", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.string   "rent"
    t.string   "area"
    t.string   "style"
    t.string   "floor"
    t.string   "config"
    t.text     "description"
    t.string   "pub_person"
    t.string   "pub_person_tel_image_url"
    t.datetime "pub_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "district"
    t.string   "pub_phone"
    t.integer  "category_id",              :default => 0
  end

  create_table "novels", :force => true do |t|
    t.integer  "category_id", :default => 0
    t.string   "title",       :default => "小说",                           :null => false
    t.string   "author",      :default => "网友",                           :null => false
    t.text     "synopsis"
    t.integer  "word_num",    :default => 0,                              :null => false
    t.datetime "created_at"
    t.string   "from_name",   :default => "未知",                           :null => false
    t.string   "from_url",    :default => "http://www.lehazi.com/novels", :null => false
    t.text     "other_from"
    t.boolean  "free",        :default => false
    t.integer  "click_time",  :default => 0,                              :null => false
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "f_level_num", :default => 1
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"

  create_table "rent_infos", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.string   "rent"
    t.integer  "area"
    t.string   "style"
    t.integer  "floor"
    t.string   "config"
    t.text     "description"
    t.string   "pub_person"
    t.string   "pub_person_tel_image_url"
    t.datetime "pub_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count",     :default => 0,  :null => false
    t.integer  "click_times",     :default => 1
    t.string   "from_url",        :default => ""
    t.string   "f_category",      :default => ""
    t.string   "f_username",      :default => ""
    t.string   "last_from_url"
    t.datetime "f_updated_at"
    t.datetime "f_lz_updated_at"
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"

  create_table "users", :force => true do |t|
    t.string   "login",                                           :null => false
    t.string   "email",                                           :null => false
    t.string   "crypted_password",                                :null => false
    t.string   "password_salt",                                   :null => false
    t.string   "persistence_token",                               :null => false
    t.string   "single_access_token",                             :null => false
    t.string   "perishable_token",                                :null => false
    t.integer  "login_count",         :default => 0,              :null => false
    t.integer  "failed_login_count",  :default => 0,              :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",             :default => true,           :null => false
    t.integer  "posts_count",         :default => 0,              :null => false
    t.integer  "entries_count",       :default => 0,              :null => false
    t.string   "blog_title"
    t.boolean  "enabled_comments",    :default => true
    t.string   "portrait_location",   :default => "portrait.jpg", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["persistence_token"], :name => "idx_users_persistence", :unique => true

end
