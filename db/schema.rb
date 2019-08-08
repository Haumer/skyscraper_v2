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

ActiveRecord::Schema.define(version: 20190808095725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "company"
    t.string "location"
    t.string "link"
    t.string "job_website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "search_id"
    t.string "salary"
    t.index ["search_id"], name: "index_jobs_on_search_id"
  end

  create_table "scrapers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "website_id"
    t.string "card_class"
    t.string "title_class"
    t.string "salary_class"
    t.string "location_class"
    t.string "link_class"
    t.string "company_class"
    t.string "scrape_url"
    t.integer "counter_interval"
    t.integer "nr_pages"
    t.string "description_class"
    t.string "counter_start"
    t.index ["website_id"], name: "index_scrapers_on_website_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "location"
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "websites", force: :cascade do |t|
    t.string "name"
    t.string "base_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "jobs", "searches"
  add_foreign_key "scrapers", "websites"
  add_foreign_key "searches", "users"
end
