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

ActiveRecord::Schema.define(version: 20180917142009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "response_id"
    t.jsonb "raw"
    t.string "answerable_type"
    t.bigint "answerable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answerable_type", "answerable_id"], name: "index_answers_on_answerable_type_and_answerable_id"
    t.index ["response_id"], name: "index_answers_on_response_id"
  end

  create_table "classification_translations", force: :cascade do |t|
    t.integer "classification_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.text "results_description"
    t.index ["classification_id"], name: "index_classification_translations_on_classification_id"
    t.index ["locale"], name: "index_classification_translations_on_locale"
  end

  create_table "classifications", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "results_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customised_question_translations", force: :cascade do |t|
    t.integer "customised_question_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text"
    t.index ["customised_question_id"], name: "index_396ea3e95db45ddb3189b19b1ec5229bbf128f0a"
    t.index ["locale"], name: "index_customised_question_translations_on_locale"
  end

  create_table "customised_questions", force: :cascade do |t|
    t.bigint "demographic_question_id"
    t.bigint "survey_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["demographic_question_id"], name: "index_customised_questions_on_demographic_question_id"
    t.index ["survey_id"], name: "index_customised_questions_on_survey_id"
  end

  create_table "demographic_question_translations", force: :cascade do |t|
    t.integer "demographic_question_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text"
    t.index ["demographic_question_id"], name: "index_9bfb807794557055896440a7791a7c2d67eb43cb"
    t.index ["locale"], name: "index_demographic_question_translations_on_locale"
  end

  create_table "demographic_questions", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question_type"
    t.jsonb "validation"
    t.boolean "customisable", default: false
  end

  create_table "option_translations", force: :cascade do |t|
    t.integer "option_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text"
    t.index ["locale"], name: "index_option_translations_on_locale"
    t.index ["option_id"], name: "index_option_translations_on_option_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "optionable_id"
    t.string "optionable_type"
    t.index ["optionable_id", "optionable_type"], name: "index_options_on_optionable_id_and_optionable_type"
  end

  create_table "question_translations", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "text"
    t.index ["locale"], name: "index_question_translations_on_locale"
    t.index ["question_id"], name: "index_question_translations_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "x_weight"
    t.float "y_weight"
    t.float "z_weight"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "ip_address"
    t.string "language"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "x_score"
    t.float "y_score"
    t.float "z_score"
    t.bigint "classification_id"
    t.index ["classification_id"], name: "index_responses_on_classification_id"
    t.index ["survey_id"], name: "index_responses_on_survey_id"
  end

  create_table "survey_translations", force: :cascade do |t|
    t.integer "survey_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.index ["locale"], name: "index_survey_translations_on_locale"
    t.index ["survey_id"], name: "index_survey_translations_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "name"
    t.boolean "published"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", null: false
    t.text "description"
    t.boolean "locked", default: false
    t.boolean "master", default: false
    t.index ["user_id"], name: "index_surveys_on_user_id"
    t.index ["uuid"], name: "index_surveys_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", null: false
    t.string "organisation_name", null: false
    t.boolean "admin", default: false, null: false
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
    t.integer "use_type", default: 0
    t.string "org_type", default: "", null: false
    t.string "org_type_other", default: ""
    t.string "country", default: ""
    t.boolean "wider_network", default: false, null: false
    t.string "wider_network_details", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "responses"
  add_foreign_key "customised_questions", "demographic_questions"
  add_foreign_key "customised_questions", "surveys"
  add_foreign_key "responses", "surveys"
  add_foreign_key "surveys", "users"
end
