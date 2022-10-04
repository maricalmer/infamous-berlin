# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_09_17_144447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "chatrooms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "author_id", null: false
    t.integer "receiver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id", "receiver_id"], name: "index_chatrooms_on_author_id_and_receiver_id", unique: true
    t.index ["author_id"], name: "index_chatrooms_on_author_id"
    t.index ["receiver_id"], name: "index_chatrooms_on_receiver_id"
    t.index ["updated_at"], name: "index_chatrooms_on_updated_at"
  end

  create_table "collabs", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_collabs_on_project_id"
    t.index ["user_id"], name: "index_collabs_on_user_id"
  end

# Could not dump table "inquiries" because of following StandardError
#   Unknown type 'inquiry_status' for column 'status'

# Could not dump table "jobs" because of following StandardError
#   Unknown type 'job_payment' for column 'payment'

  create_table "messages", force: :cascade do |t|
    t.string "content", null: false
    t.integer "anchor_id", null: false
    t.boolean "read_by_receiver", default: false
    t.uuid "chatroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["anchor_id"], name: "index_messages_on_anchor_id"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["chatroom_id"], name: "messages_chatroom_id_idx"
    t.index ["user_id"], name: "index_messages_on_user_id"
    t.index ["user_id"], name: "messages_user_id_idx"
  end

  create_table "mirrors", force: :cascade do |t|
    t.string "img_key"
    t.string "grid_x"
    t.string "grid_y"
    t.string "grid_h"
    t.string "grid_w"
    t.string "crop_x"
    t.string "crop_y"
    t.string "crop_h"
    t.string "crop_w"
    t.integer "default_position"
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_mirrors_on_project_id"
    t.index ["user_id"], name: "index_mirrors_on_user_id"
  end

# Could not dump table "projects" because of following StandardError
#   Unknown type 'project_status' for column 'status'

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "bio"
    t.string "skills"
    t.string "slug"
    t.citext "username"
    t.string "title"
    t.string "website"
    t.string "facebook"
    t.string "instagram"
    t.string "soundcloud"
    t.string "youtube"
    t.string "mixcloud"
    t.string "linkedin"
    t.string "twitter"
    t.boolean "admin", default: false, null: false
    t.index ["bio"], name: "index_users_on_bio"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["facebook"], name: "index_users_on_facebook"
    t.index ["instagram"], name: "index_users_on_instagram"
    t.index ["linkedin"], name: "index_users_on_linkedin"
    t.index ["mixcloud"], name: "index_users_on_mixcloud"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["skills"], name: "index_users_on_skills"
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["soundcloud"], name: "index_users_on_soundcloud"
    t.index ["title"], name: "index_users_on_title"
    t.index ["twitter"], name: "index_users_on_twitter"
    t.index ["username"], name: "index_users_on_username", unique: true
    t.index ["website"], name: "index_users_on_website"
    t.index ["youtube"], name: "index_users_on_youtube"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "collabs", "projects"
  add_foreign_key "collabs", "users"
  add_foreign_key "inquiries", "jobs"
  add_foreign_key "inquiries", "users"
  add_foreign_key "jobs", "projects"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "mirrors", "projects"
  add_foreign_key "mirrors", "users"
  add_foreign_key "projects", "users"
end
