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

ActiveRecord::Schema.define(:version => 20140616032706) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "active"
  end

  add_index "accounts", ["player_id"], :name => "index_accounts_on_player_id"
  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "friendships", :force => true do |t|
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "player_id"
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"

  create_table "matches", :force => true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.string   "result"
    t.string   "score"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "link"
    t.string   "date"
    t.string   "doubles"
    t.string   "partner"
    t.string   "round"
  end

  add_index "matches", ["player1_id"], :name => "index_matches_on_player1_id"
  add_index "matches", ["player2_id"], :name => "index_matches_on_player2_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "usta_id"
    t.integer  "user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "location"
    t.string   "overall_record"
    t.string   "date_range"
    t.string   "image"
    t.string   "gender"
    t.datetime "birthday"
    t.string   "parent_email"
    t.string   "racket"
    t.string   "strings"
    t.string   "shoes"
    t.string   "clothing"
    t.string   "hand"
    t.string   "hometown"
    t.string   "school"
    t.string   "grade"
    t.string   "user_usta_id"
    t.string   "section"
    t.string   "club"
    t.string   "favorites"
    t.string   "mentor"
    t.string   "coach"
    t.text     "colleges"
    t.string   "district"
  end

  add_index "players", ["user_id"], :name => "index_players_on_user_id"

  create_table "tmatches", :force => true do |t|
    t.integer  "tournament_id"
    t.string   "score"
    t.string   "result"
    t.string   "player"
    t.string   "player_1"
    t.string   "player_2"
    t.string   "round"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "tmatches", ["tournament_id"], :name => "index_tmatches_on_tournament_id"

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "result"
    t.datetime "date"
    t.text     "comments"
    t.string   "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "player_id"
    t.string   "player_1"
    t.string   "player_2"
  end

  add_index "tournaments", ["player_id"], :name => "index_tournaments_on_player_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "usta_id"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
