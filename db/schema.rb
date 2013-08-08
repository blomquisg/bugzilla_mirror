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

ActiveRecord::Schema.define(:version => 20130807201454) do

  create_table "bz_queries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "product"
    t.string   "flag"
    t.string   "bug_status"
    t.string   "output_format"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "bz_query_outputs", :force => true do |t|
    t.integer  "bz_query_id"
    t.text     "output"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.text     "product",     :limit => 255
    t.text     "flag",        :limit => 255
    t.text     "bug_status",  :limit => 255
    t.text     "bz_id",       :limit => 255
    t.text     "version",     :limit => 255
  end

  add_index "bz_query_outputs", ["bz_query_id"], :name => "index_bz_query_outputs_on_bz_query_id"

  create_table "report_tables", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "query_name"
    t.string   "vertical"
    t.string   "horizontal"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "query_id"
  end

end