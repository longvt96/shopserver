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

ActiveRecord::Schema.define(version: 20180429081726) do

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "content"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "is_thumb",                   default: 0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "number_favorites"
    t.integer  "sale",             default: 0
    t.integer  "price"
    t.integer  "category_id"
    t.integer  "shop_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "gender"
    t.datetime "date_of_birth"
    t.string   "phone_number"
    t.string   "address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "title"
    t.string   "address"
    t.string   "phone_nunber"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_carts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_product_favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
