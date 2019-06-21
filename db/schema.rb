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

ActiveRecord::Schema.define(version: 2019_06_18_145715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer "venue_id"
    t.integer "organization_id"
    t.string "name"
    t.text "description"
    t.string "url"
    t.string "cost"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "remote_id"
    t.float "rating"
    t.index ["name"], name: "index_events_on_name"
    t.index ["organization_id"], name: "index_events_on_organization_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "address", limit: 100
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.float "rating"
    t.index ["name"], name: "index_organizations_on_name"
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.string "email", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", limit: 50
    t.string "password_digest"
    t.index ["username"], name: "index_users_on_username"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "slug"
    t.bigint "remote_id"
    t.float "rating"
    t.index ["name"], name: "index_venues_on_name"
    t.index ["remote_id"], name: "index_venues_on_remote_id"
    t.index ["slug"], name: "index_venues_on_slug", unique: true
  end

end
