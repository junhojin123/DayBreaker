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

ActiveRecord::Schema.define(version: 20140928200042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "tasks", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "due_at"
    t.boolean  "completed",                                    default: false, null: false
    t.decimal  "estimated_hours",     precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "completed_hours",     precision: 10, scale: 2, default: 0.0,   null: false
    t.date     "completed_on"
    t.decimal  "old_completed_hours", precision: 10, scale: 2, default: 0.0,   null: false
  end

  create_table "users", id: false, force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email",                                           default: "",                   null: false
    t.string   "encrypted_password",                              default: "",                   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                   default: 0,                    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.uuid     "id",                                              default: "uuid_generate_v1()"
    t.integer  "days_to_show_at_once",                            default: 3,                    null: false
    t.decimal  "max_hours_per_day",      precision: 10, scale: 2, default: 8.0,                  null: false
    t.decimal  "min_hours_per_task",     precision: 10, scale: 2, default: 0.25,                 null: false
    t.decimal  "max_hours_per_task",     precision: 10, scale: 2, default: 4.0,                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
