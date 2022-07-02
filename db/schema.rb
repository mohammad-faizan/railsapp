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

ActiveRecord::Schema.define(version: 2022_06_28_183504) do

  create_table "interview_rounds", charset: "utf8", force: :cascade do |t|
    t.bigint "interview_id"
    t.bigint "employee_id"
    t.datetime "when"
    t.string "where"
    t.text "review_comments"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_interview_rounds_on_employee_id"
    t.index ["interview_id"], name: "index_interview_rounds_on_interview_id"
  end

  create_table "interviews", charset: "utf8", force: :cascade do |t|
    t.bigint "candidate_id"
    t.text "requirements"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_interviews_on_candidate_id"
  end

  create_table "people", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.date "dob"
    t.string "email"
    t.integer "experience"
    t.string "type"
    t.bigint "person_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_people_on_person_id"
  end

  create_table "people_skills", charset: "utf8", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "skill_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_people_skills_on_person_id"
    t.index ["skill_id"], name: "index_people_skills_on_skill_id"
  end

  create_table "skill_ratings", charset: "utf8", force: :cascade do |t|
    t.bigint "interview_round_id"
    t.bigint "skill_id"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interview_round_id"], name: "index_skill_ratings_on_interview_round_id"
    t.index ["skill_id"], name: "index_skill_ratings_on_skill_id"
  end

  create_table "skills", charset: "utf8", force: :cascade do |t|
    t.string "skill_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
