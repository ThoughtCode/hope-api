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

ActiveRecord::Schema.define(version: 20181012214333) do

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
    t.integer "mobile_token"
    t.datetime "mobile_token_expiration"
    t.boolean "online", default: true
    t.string "avatar"
    t.integer "status", default: 0
    t.string "hashed_id"
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "configs", force: :cascade do |t|
    t.string "key"
    t.text "description"
    t.string "value"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "holder_name"
    t.string "card_type"
    t.string "number"
    t.string "customer_id"
    t.string "token"
    t.string "status"
    t.string "expiry_month"
    t.string "expiry_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_id"
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
    t.string "avatar"
    t.integer "mobile_token"
    t.datetime "mobile_token_expiration"
    t.integer "penalties_id"
    t.string "hashed_id"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "holidays", force: :cascade do |t|
    t.date "holiday_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_details", force: :cascade do |t|
    t.integer "job_id"
    t.integer "service_id"
    t.integer "value"
    t.float "time"
    t.decimal "price_total", precision: 8, scale: 2
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "property_id"
    t.float "duration"
    t.integer "agent_id"
    t.string "hashed_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer "status", default: 0
    t.integer "frequency", default: 0
    t.text "details"
    t.datetime "finished_recurrency_at"
    t.string "card_id"
    t.integer "installments"
    t.decimal "total", precision: 8, scale: 2
    t.decimal "vat", precision: 8, scale: 2
    t.decimal "service_fee", precision: 8, scale: 2
    t.decimal "subtotal", precision: 8, scale: 2
    t.decimal "agent_earnings", precision: 8, scale: 2
    t.boolean "closed_by_agent"
    t.boolean "payment_started", default: false
    t.boolean "review_notification_send", default: false
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

  create_table "notifications", force: :cascade do |t|
    t.string "text"
    t.bigint "customer_id"
    t.bigint "agent_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.index ["agent_id"], name: "index_notifications_on_agent_id"
    t.index ["customer_id"], name: "index_notifications_on_customer_id"
    t.index ["job_id"], name: "index_notifications_on_job_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "job_id"
    t.integer "credit_card_id"
    t.string "amount"
    t.string "description"
    t.string "vat"
    t.datetime "payment_date"
    t.string "authorization_code"
    t.string "installments"
    t.string "message"
    t.string "carrier_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.string "status"
    t.string "transaction_identifier"
    t.string "status_detail"
    t.boolean "receipt_send", default: false
    t.boolean "is_receipt_cancel", default: false
  end

  create_table "penalties", force: :cascade do |t|
    t.integer "amount"
    t.integer "customer_id"
    t.boolean "paid", default: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.integer "neightborhood_id"
    t.string "p_street"
    t.string "number"
    t.string "s_street"
    t.string "additional_reference"
    t.string "phone"
    t.integer "customer_id"
    t.string "hashed_id"
    t.boolean "deleted", default: false
  end

  create_table "proposals", force: :cascade do |t|
    t.string "hashed_id"
    t.integer "job_id"
    t.integer "agent_id"
    t.integer "status"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "hashed_id"
    t.bigint "job_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.text "comment"
    t.integer "qualification", default: 0
    t.integer "reviewee_id"
    t.string "reviewee_type"
    t.index ["job_id"], name: "index_reviews_on_job_id"
    t.index ["owner_type", "owner_id"], name: "index_reviews_on_owner_type_and_owner_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.string "hashed_id"
    t.string "image"
  end

  create_table "services", force: :cascade do |t|
    t.integer "service_type_id"
    t.integer "type_service"
    t.string "name"
    t.boolean "quantity"
    t.float "time"
    t.float "price"
    t.string "icon"
  end

  add_foreign_key "reviews", "jobs"
end
