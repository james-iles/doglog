# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_12_11_140951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.string "appointment_type"
    t.text "location"
    t.text "appointment_notes"
    t.string "host"
    t.bigint "dog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.index ["dog_id"], name: "index_appointments_on_dog_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "title"
    t.bigint "dog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_chats_on_dog_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "category"
    t.bigint "dog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_documents_on_dog_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.string "breed"
    t.datetime "dob"
    t.bigint "household_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.decimal "weight"
    t.string "vet_name"
    t.string "vet_clinic"
    t.string "vet_phone"
    t.text "vet_address"
    t.string "insurance_provider"
    t.string "insurance_policy_number"
    t.string "microchip_number"
    t.text "allergies"
    t.text "medications"
    t.text "special_notes"
    t.index ["household_id"], name: "index_dogs_on_household_id"
  end

  create_table "households", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_name"
    t.string "email"
    t.string "phone"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.string "role"
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "share_profile_view_logs", force: :cascade do |t|
    t.bigint "shareable_profile_id", null: false
    t.datetime "viewed_at", null: false
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shareable_profile_id"], name: "index_share_profile_view_logs_on_shareable_profile_id"
    t.index ["viewed_at"], name: "index_share_profile_view_logs_on_viewed_at"
  end

  create_table "shareable_profiles", force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.string "token", null: false
    t.string "access_pin_digest"
    t.datetime "expires_at"
    t.integer "max_views"
    t.integer "view_count", default: 0, null: false
    t.text "shared_categories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_shareable_profiles_on_dog_id"
    t.index ["token"], name: "unique_token_on_shareable_profiles", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "household_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["household_id"], name: "index_users_on_household_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "dogs"
  add_foreign_key "chats", "dogs"
  add_foreign_key "documents", "dogs"
  add_foreign_key "dogs", "households"
  add_foreign_key "messages", "chats"
  add_foreign_key "share_profile_view_logs", "shareable_profiles"
  add_foreign_key "shareable_profiles", "dogs"
  add_foreign_key "users", "households"
end
