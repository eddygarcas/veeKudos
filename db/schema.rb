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

ActiveRecord::Schema.define(version: 2020_06_26_133021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kudos", force: :cascade do |t|
    t.string "sender"
    t.string "text"
    t.string "receiver"
    t.string "channel_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "channel_name"
    t.string "team_name"
    t.string "team_id"
    t.bigint "workspace_id", null: false
    t.index ["workspace_id"], name: "index_kudos_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "team_domain"
    t.string "team_id"
    t.string "enterprise_id"
    t.string "enterprise_name"
    t.string "icon"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "kudos", "workspaces"
end
