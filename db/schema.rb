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

ActiveRecord::Schema[8.1].define(version: 2026_10_26_131622) do
  create_table "answers", force: :cascade do |t|
    t.integer "lab_work_id", null: false
    t.integer "question_id", null: false
    t.text "text_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["lab_work_id"], name: "index_answers_on_lab_work_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id", "question_id"], name: "index_answers_on_user_and_question", unique: true
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "lab_work_templates", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_lab_work_templates_on_teacher_id"
  end

  create_table "lab_works", force: :cascade do |t|
    t.integer "lab_work_template_id", null: false
    t.integer "student_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_work_template_id"], name: "index_lab_works_on_lab_work_template_id"
    t.index ["student_id"], name: "index_lab_works_on_student_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "lab_work_template_id", null: false
    t.text "content"
    t.string "question_type"
    t.boolean "required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lab_work_template_id"], name: "index_questions_on_lab_work_template_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "role", default: "student", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "answers", "lab_works"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "lab_work_templates", "users", column: "teacher_id"
  add_foreign_key "lab_works", "lab_work_templates"
  add_foreign_key "lab_works", "users", column: "student_id"
  add_foreign_key "questions", "lab_work_templates"
  add_foreign_key "sessions", "users"
end
