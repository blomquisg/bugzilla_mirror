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

ActiveRecord::Schema.define(version: 20140415123000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bugzilla_configs", force: true do |t|
    t.string "name",  null: false
    t.string "value"
  end

  add_index "bugzilla_configs", ["name"], name: "index_bugzilla_configs_on_name", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.integer  "count"
    t.text     "text"
    t.string   "created_by"
    t.datetime "created_on"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "issue_id"
  end

  add_index "comments", ["issue_id"], name: "index_comments_on_issue_id", using: :btree

  create_table "commits", force: true do |t|
    t.string   "branch"
    t.string   "sha_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commits_issues", force: true do |t|
    t.integer "issue_id"
    t.integer "commit_id"
  end

  create_table "issues", force: true do |t|
    t.string   "status"
    t.string   "assigned_to"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bug_type"
    t.string   "actual_time"
    t.string   "alias"
    t.string   "bug_group"
    t.string   "build_id"
    t.string   "category"
    t.text     "cc"
    t.string   "cc_list_accessible"
    t.string   "classification"
    t.string   "commenter"
    t.string   "component"
    t.string   "created_by"
    t.string   "cust_facing"
    t.string   "days_elapsed"
    t.string   "deadline"
    t.string   "doc_type"
    t.string   "docs_contact"
    t.string   "documentation_action"
    t.string   "environment"
    t.string   "estimated_time"
    t.string   "everconfirmed"
    t.string   "fixed_in"
    t.string   "flags"
    t.string   "internal_whiteboard"
    t.string   "keywords"
    t.string   "layered_products"
    t.string   "mount_type"
    t.string   "op_sys"
    t.string   "owner_idle_time"
    t.string   "partner"
    t.string   "percentage_complete"
    t.string   "pgm_internal"
    t.string   "platform"
    t.string   "pm_score"
    t.string   "priority"
    t.string   "product"
    t.string   "qa_contact"
    t.string   "qa_whiteboard"
    t.string   "qe_conditional_nak"
    t.string   "regression_status"
    t.text     "release_notes"
    t.string   "remaining_time"
    t.string   "reporter_accessible"
    t.string   "reporter_realname"
    t.text     "resolution"
    t.string   "rh_sub_components"
    t.text     "see_also"
    t.string   "severity"
    t.string   "story_points"
    t.string   "tag"
    t.string   "target_milestone"
    t.string   "target_release"
    t.string   "url"
    t.string   "vcs_commits"
    t.string   "verified"
    t.string   "verified_branch"
    t.string   "version"
    t.string   "view"
    t.string   "votes"
    t.string   "whiteboard"
    t.string   "work_time"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "bug_id"
  end

  add_index "issues", ["assigned_to"], name: "index_issues_on_assigned_to", using: :btree
  add_index "issues", ["classification"], name: "index_issues_on_classification", using: :btree
  add_index "issues", ["created_on"], name: "index_issues_on_created_on", using: :btree
  add_index "issues", ["priority"], name: "index_issues_on_priority", using: :btree
  add_index "issues", ["severity"], name: "index_issues_on_severity", using: :btree
  add_index "issues", ["status"], name: "index_issues_on_status", using: :btree
  add_index "issues", ["updated_on"], name: "index_issues_on_updated_on", using: :btree

  create_table "issues_blocks", id: false, force: true do |t|
    t.integer "issue_id"
    t.integer "blocked_issue_id"
  end

  add_index "issues_blocks", ["blocked_issue_id"], name: "index_issues_blocks_on_blocked_issue_id", using: :btree
  add_index "issues_blocks", ["issue_id"], name: "index_issues_blocks_on_issue_id", using: :btree

  create_table "issues_clones", id: false, force: true do |t|
    t.integer "issue_id"
    t.integer "clone_id"
  end

  add_index "issues_clones", ["clone_id"], name: "index_issues_clones_on_clone_id", using: :btree
  add_index "issues_clones", ["issue_id"], name: "index_issues_clones_on_issue_id", using: :btree

  create_table "issues_dependencies", id: false, force: true do |t|
    t.integer "issue_id"
    t.integer "dependent_id"
  end

  add_index "issues_dependencies", ["dependent_id"], name: "index_issues_dependencies_on_dependent_id", using: :btree
  add_index "issues_dependencies", ["issue_id"], name: "index_issues_dependencies_on_issue_id", using: :btree

  create_table "issues_duplicates", id: false, force: true do |t|
    t.integer "issue_id"
    t.integer "duplicate_id"
  end

  add_index "issues_duplicates", ["duplicate_id"], name: "index_issues_duplicates_on_duplicate_id", using: :btree
  add_index "issues_duplicates", ["issue_id"], name: "index_issues_duplicates_on_issue_id", using: :btree

end
