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

ActiveRecord::Schema[8.1].define(version: 2025_11_22_143912) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "lessons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "difficulty_level"
    t.text "lesson_text"
    t.integer "profile_id", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_lessons_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.integer "profile_id", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.string "video_url"
    t.integer "voice_sample_id", null: false
    t.index ["lesson_id"], name: "index_videos_on_lesson_id"
    t.index ["profile_id"], name: "index_videos_on_profile_id"
    t.index ["voice_sample_id"], name: "index_videos_on_voice_sample_id"
  end

  create_table "voice_samples", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "duration"
    t.integer "profile_id", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_voice_samples_on_profile_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "lessons", "profiles"
  add_foreign_key "videos", "lessons"
  add_foreign_key "videos", "profiles"
  add_foreign_key "videos", "voice_samples"
  add_foreign_key "voice_samples", "profiles"
end
