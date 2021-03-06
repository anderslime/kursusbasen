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

ActiveRecord::Schema.define(version: 20140727191430) do

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

  create_table "course_plannings", force: true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedule_group_id"
    t.string   "year"
    t.string   "semester_season_start"
    t.string   "category",              default: "master"
    t.string   "programme"
    t.string   "course_type"
  end

  add_index "course_plannings", ["course_id"], name: "index_course_plannings_on_course_id", using: :btree
  add_index "course_plannings", ["student_id", "course_id"], name: "index_course_plannings_on_student_id_and_course_id", unique: true, using: :btree
  add_index "course_plannings", ["student_id"], name: "index_course_plannings_on_student_id", using: :btree

  create_table "course_translations", force: true do |t|
    t.integer  "course_id",                    null: false
    t.string   "locale",                       null: false
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
    t.text     "qualified_prerequisites_text"
    t.text     "mandatory_prerequisites_text"
  end

  add_index "course_translations", ["course_id"], name: "index_course_translations_on_course_id", using: :btree
  add_index "course_translations", ["locale"], name: "index_course_translations_on_locale", using: :btree

  create_table "courses", force: true do |t|
    t.string   "course_number",                          null: false
    t.string   "language"
    t.float    "ects_points"
    t.integer  "institute_id"
    t.string   "homepage"
    t.string   "exam_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open_education",         default: false
    t.text     "schedule_season_blocks"
    t.boolean  "removed",                default: false, null: false
  end

  add_index "courses", ["course_number"], name: "index_courses_on_course_number", using: :btree

  create_table "courses_prerequisites", force: true do |t|
    t.integer "course_id"
    t.integer "prerequisite_id"
  end

  create_table "courses_qualified_prerequisites", force: true do |t|
    t.integer "course_id"
    t.integer "qualified_prerequisite_id"
  end

  create_table "courses_schedule_groups", force: true do |t|
    t.integer "course_id"
    t.integer "schedule_group_id"
  end

  add_index "courses_schedule_groups", ["course_id", "schedule_group_id"], name: "unique_courses_schedule_groups", unique: true, using: :btree

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

  create_table "prerequisites", force: true do |t|
    t.integer  "course_id"
    t.string   "prerequisite_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qualified_prerequisites", force: true do |t|
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_groups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "block"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedule_group_id"
    t.boolean  "outside_dtu_schedule", default: false
    t.string   "season"
  end

  add_index "schedules", ["schedule_group_id"], name: "index_schedules_on_schedule_group_id", using: :btree

  create_table "special_courses", force: true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.float    "ects_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "special_courses", ["creator_id"], name: "index_special_courses_on_creator_id", using: :btree

  create_table "special_courses_schedule_groups", force: true do |t|
    t.integer "special_course_id"
    t.integer "schedule_group_id"
  end

  create_table "students", force: true do |t|
    t.string   "student_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["student_number"], name: "index_students_on_student_number", unique: true, using: :btree

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
