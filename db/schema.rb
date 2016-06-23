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

ActiveRecord::Schema.define(version: 20160623095436) do

  create_table "billing_addresses", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "company"
    t.text     "address"
    t.integer  "zip"
    t.string   "city"
    t.string   "province"
    t.string   "telephone"
    t.string   "email"
    t.string   "vat"
    t.integer  "order_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "shipping_table_rate_id"
  end

  add_index "billing_addresses", ["cart_id"], name: "index_billing_addresses_on_cart_id"
  add_index "billing_addresses", ["order_id"], name: "index_billing_addresses_on_order_id"
  add_index "billing_addresses", ["shipping_table_rate_id"], name: "index_billing_addresses_on_shipping_table_rate_id"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id"
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.string   "pay_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.decimal  "shipping_cost"
  end

  create_table "products", force: :cascade do |t|
    t.string   "sku"
    t.string   "title"
    t.text     "description"
    t.decimal  "capacity_cl"
    t.decimal  "height"
    t.decimal  "diameter"
    t.decimal  "price"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.decimal  "capacity_floz"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "company"
    t.text     "address"
    t.integer  "zip"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "telephone"
    t.integer  "order_id"
    t.integer  "cart_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "shipping_table_rate_id"
  end

  add_index "shipping_addresses", ["cart_id"], name: "index_shipping_addresses_on_cart_id"
  add_index "shipping_addresses", ["order_id"], name: "index_shipping_addresses_on_order_id"
  add_index "shipping_addresses", ["shipping_table_rate_id"], name: "index_shipping_addresses_on_shipping_table_rate_id"

  create_table "shipping_table_rates", force: :cascade do |t|
    t.string   "country"
    t.decimal  "a"
    t.decimal  "b"
    t.decimal  "c"
    t.decimal  "d"
    t.decimal  "e"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
