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

ActiveRecord::Schema.define(version: 2019_12_20_174938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "homeworlds", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name", limit: 100
    t.decimal "mass"
    t.bigint "homeworld_id"
    t.string "birth_year", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["homeworld_id"], name: "index_people_on_homeworld_id"
  end

  create_table "person_dependents", force: :cascade do |t|
    t.bigint "person_id"
    t.string "dependent_type"
    t.bigint "dependent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dependent_type", "dependent_id"], name: "index_person_dependents_on_dependent_type_and_dependent_id"
    t.index ["person_id"], name: "index_person_dependents_on_person_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "starships", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "people", "homeworlds"
end
