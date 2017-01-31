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

ActiveRecord::Schema.define(version: 20170119141744) do

  create_table "banners", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brand_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "brand_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "brand_categories", ["brand_id"], name: "index_brand_categories_on_brand_id"
  add_index "brand_categories", ["category_id"], name: "index_brand_categories_on_category_id"

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "cart_items", ["customer_id"], name: "index_cart_items_on_customer_id"
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status"
  end

  add_index "categories", ["category_id"], name: "index_categories_on_category_id"

  create_table "coustomers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.string   "short_description"
    t.integer  "status"
    t.integer  "quantity"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "brand_id"
    t.integer  "category_id"
    t.string   "sku"
    t.decimal  "special_price"
    t.text     "long_description"
    t.string   "meta_title"
    t.text     "meta_description"
    t.text     "meta_keywords"
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id"
  add_index "products", ["category_id"], name: "index_products_on_category_id"

end
