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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121019111051) do

  create_table "answer_stores", :force => true do |t|
    t.string   "session_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "answer_stores_answers", :id => false, :force => true do |t|
    t.integer "answer_id"
    t.integer "answer_store_id"
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "value"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "questionnaire_id"
  end

  create_table "answers_rule_sets", :id => false, :force => true do |t|
    t.integer "answer_id"
    t.integer "rule_set_id"
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "button_image_file_name"
    t.string   "button_image_content_type"
    t.integer  "button_image_file_size"
    t.datetime "button_image_updated_at"
  end

  create_table "questionnaires_questions", :id => false, :force => true do |t|
    t.integer "questionnaire_id"
    t.integer "question_id"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rule_sets", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
