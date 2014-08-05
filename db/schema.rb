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

ActiveRecord::Schema.define(version: 20140805060746) do

  create_table "incomes", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.decimal  "amount"
    t.date     "earning_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invests", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.date     "earning_date"
    t.string   "seven_year_yield"
    t.string   "earning_per_million"
    t.string   "scale"
    t.string   "ranking"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "money_fund"
    t.text     "url"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.decimal  "amount",      precision: 13, scale: 2, default: 0.0
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.string   "invest_type"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.string   "last_ip"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",            default: "user"
  end

end
