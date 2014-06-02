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

ActiveRecord::Schema.define(version: 20140602065815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_pages", force: true do |t|
    t.string   "course_number", null: false
    t.text     "page",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "semester_year"
    t.string   "url"
  end

  add_index "course_pages", ["course_number", "semester_year"], name: "index_course_pages_on_course_number_and_semester_year", using: :btree
  add_index "course_pages", ["course_number"], name: "index_course_pages_on_course_number", using: :btree

  create_table "course_translations", force: true do |t|
    t.integer  "course_id",          null: false
    t.string   "locale",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "teaching_form"
    t.string   "duration"
    t.string   "participant_limit"
    t.string   "registration"
    t.text     "course_objectives"
    t.text     "exam_schedule"
    t.text     "learn_objectives"
    t.text     "content"
    t.text     "litteratur"
    t.text     "remarks"
    t.text     "top_comment"
    t.string   "former_course"
    t.text     "exam_form"
    t.string   "exam_aid"
    t.string   "evaluation_form"
    t.text     "exam_schedule_note"
    t.text     "schedule_note"
  end

  add_index "course_translations", ["course_id"], name: "index_course_translations_on_course_id", using: :btree
  add_index "course_translations", ["locale"], name: "index_course_translations_on_locale", using: :btree

  create_table "courses", force: true do |t|
    t.string   "course_number",                         null: false
    t.string   "language"
    t.float    "ects_points"
    t.integer  "institute_id"
    t.string   "homepage"
    t.string   "exam_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open_education",        default: false
    t.string   "schedule_season_block"
  end

  add_index "courses", ["course_number"], name: "index_courses_on_course_number", using: :btree

  create_table "courses_teachers", id: false, force: true do |t|
    t.integer "course_id",  null: false
    t.integer "teacher_id", null: false
  end

  add_index "courses_teachers", ["course_id", "teacher_id"], name: "index_courses_teachers_on_course_id_and_teacher_id", using: :btree
  add_index "courses_teachers", ["teacher_id", "course_id"], name: "index_courses_teachers_on_teacher_id_and_course_id", using: :btree

  create_table "institute_translations", force: true do |t|
    t.integer  "institute_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "institute_translations", ["institute_id"], name: "index_institute_translations_on_institute_id", using: :btree
  add_index "institute_translations", ["locale"], name: "index_institute_translations_on_locale", using: :btree

  create_table "institutes", force: true do |t|
    t.string   "dtu_institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "course_id"
    t.string   "block"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["course_id"], name: "index_schedules_on_course_id", using: :btree

  create_table "teacher_pages", force: true do |t|
    t.string   "dtu_teacher_id"
    t.text     "page"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.string   "office_location"
    t.string   "phone"
    t.string   "email"
    t.string   "dtu_teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

end
