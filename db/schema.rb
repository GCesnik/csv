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

ActiveRecord::Schema.define(version: 2019_09_16_024809) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csv_uploads", force: :cascade do |t|
    t.string "identifier"
    t.string "csv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_errors", force: :cascade do |t|
    t.integer "row_number"
    t.string "error_message"
    t.bigint "csv_upload_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_upload_id"], name: "index_import_errors_on_csv_upload_id"
  end

  create_table "records", force: :cascade do |t|
    t.string "first"
    t.string "last"
    t.string "phone"
    t.string "email"
    t.bigint "csv_upload_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_upload_id"], name: "index_records_on_csv_upload_id"
  end

end
