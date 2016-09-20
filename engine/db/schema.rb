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

ActiveRecord::Schema.define(version: 20160919145622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "chapters", force: :cascade do |t|
    t.integer  "course_id",                    null: false
    t.integer  "position",     default: 0,     null: false
    t.string   "name",                         null: false
    t.text     "description",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "content_type", default: 0,     null: false
    t.string   "code",                         null: false
    t.integer  "section_id",                   null: false
    t.boolean  "is_demo",      default: false
  end

  add_index "chapters", ["code"], name: "index_chapters_on_code", using: :btree
  add_index "chapters", ["course_id", "position"], name: "index_chapters_on_course_id_and_position", unique: true, using: :btree
  add_index "chapters", ["course_id"], name: "index_chapters_on_course_id", using: :btree
  add_index "chapters", ["section_id"], name: "index_chapters_on_section_id", using: :btree

  create_table "cheatsheets", force: :cascade do |t|
    t.integer "course_id", null: false
    t.string  "code",      null: false
  end

  add_index "cheatsheets", ["course_id", "code"], name: "index_cheatsheets_on_course_id_and_code", unique: true, using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "code",                         null: false
    t.integer  "course_id",                    null: false
    t.integer  "discount_percent", default: 0, null: false
    t.integer  "redeem_limit",     default: 1, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "discount_cents",   default: 0
  end

  add_index "coupons", ["code"], name: "index_coupons_on_code", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "code",                              null: false
    t.string   "name",                              null: false
    t.integer  "level",                 default: 0, null: false
    t.integer  "completion_time_hours",             null: false
    t.text     "description",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "requirements"
    t.integer  "price_cents",           default: 0, null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.integer  "chapter_id",             null: false
    t.integer  "position",   default: 0, null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercises", ["chapter_id", "position"], name: "index_exercises_on_chapter_id_and_position", unique: true, using: :btree
  add_index "exercises", ["chapter_id"], name: "index_exercises_on_chapter_id", using: :btree

  create_table "job_assets", force: :cascade do |t|
    t.integer  "job_id",     null: false
    t.string   "file",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "token",                  null: false
    t.integer  "language",   default: 0, null: false
    t.text     "files",                  null: false
    t.integer  "status",     default: 0, null: false
    t.integer  "result",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meta"
    t.integer  "user_id",                null: false
  end

  add_index "jobs", ["token"], name: "index_jobs_on_token", unique: true, using: :btree

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "course_id",    null: false
    t.integer  "charge_cents", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "redemptions", force: :cascade do |t|
    t.integer  "coupon_id",   null: false
    t.integer  "user_id",     null: false
    t.datetime "redeemed_at", null: false
  end

  add_index "redemptions", ["coupon_id", "user_id"], name: "index_redemptions_on_coupon_id_and_user_id", unique: true, using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "course_id",   null: false
    t.string   "code",        null: false
    t.string   "name",        null: false
    t.integer  "position",    null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sections", ["course_id", "code"], name: "index_sections_on_course_id_and_code", unique: true, using: :btree
  add_index "sections", ["course_id", "position"], name: "index_sections_on_course_id_and_position", unique: true, using: :btree

  create_table "user_completions", force: :cascade do |t|
    t.integer  "completable_id",   null: false
    t.string   "completable_type", null: false
    t.integer  "user_id",          null: false
    t.datetime "started_at",       null: false
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_completions", ["completable_type", "completable_id"], name: "index_user_completions_on_completable_type_and_completable_id", using: :btree
  add_index "user_completions", ["user_id", "completable_type", "completable_id"], name: "index_user_completable_on_user_completions", unique: true, using: :btree

  create_table "user_courses", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "course_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_courses", ["user_id", "course_id"], name: "index_user_courses_on_user_id_and_course_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "stripe_customer_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "is_subscribed",          default: true
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "chapters", "courses"
  add_foreign_key "cheatsheets", "courses"
  add_foreign_key "coupons", "courses"
  add_foreign_key "exercises", "chapters"
  add_foreign_key "job_assets", "jobs"
  add_foreign_key "jobs", "users"
  add_foreign_key "purchases", "courses"
  add_foreign_key "purchases", "users"
  add_foreign_key "redemptions", "coupons"
  add_foreign_key "redemptions", "users"
  add_foreign_key "sections", "courses"
  add_foreign_key "user_completions", "users"
  add_foreign_key "user_courses", "courses"
  add_foreign_key "user_courses", "users"
end
