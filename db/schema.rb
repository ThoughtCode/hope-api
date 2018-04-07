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

ActiveRecord::Schema.define(version: 20180406182012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "first_name"
    t.string "last_name"
    t.string "national_id"
    t.string "cell_phone"
    t.date "birthday"
    t.integer "status"
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "access_token"
    t.string "first_name"
    t.string "last_name"
    t.string "national_id"
    t.string "cell_phone"
    t.date "birthday"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "job_details", force: :cascade do |t|
    t.integer "job_id"
    t.integer "service_id"
    t.integer "value"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "property_id"
    t.integer "agent_id", null: false
    t.integer "service_id"
    t.integer "status"
  end

  create_table "managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
  end

  create_table "neightborhoods", force: :cascade do |t|
    t.string "name"
    t.integer "city_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.integer "neightborhood_id"
    t.string "p_street"
    t.string "number"
    t.string "s_street"
    t.string "details"
    t.string "additional_reference"
    t.string "phone"
    t.string "cell_phone"
    t.integer "customer_id"
    t.string "hashed_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "services", force: :cascade do |t|
    t.integer "service_type_id"
    t.integer "type_service"
    t.string "name"
    t.boolean "quantity"
    t.integer "value"
    t.float "price"
  end

end
