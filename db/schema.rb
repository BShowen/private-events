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

ActiveRecord::Schema.define(version: 2020_03_27_212951) do

  create_table "event_manifests", force: :cascade do |t|
    t.integer "attendee_id"
    t.integer "attended_event_id"
    t.index ["attended_event_id"], name: "index_event_manifests_on_attended_event_id"
    t.index ["attendee_id"], name: "index_event_manifests_on_attendee_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_name"
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "creator_id"
    t.index ["creator_id"], name: "index_events_on_creator_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "invite_sender_id"
    t.integer "event_id"
    t.integer "invite_receiver_id"
    t.boolean "accepted", default: false
    t.index ["event_id"], name: "index_invitations_on_event_id"
    t.index ["invite_receiver_id"], name: "index_invitations_on_invite_receiver_id"
    t.index ["invite_sender_id"], name: "index_invitations_on_invite_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "events", "users", column: "creator_id"
end