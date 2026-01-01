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

ActiveRecord::Schema[8.0].define(version: 2026_01_01_062109) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attribute_enhancements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.json "assignment_effects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_per_level"
  end

  create_table "attribute_limiters", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.json "assignment_effects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_per_level"
  end

  create_table "besm_attributes", force: :cascade do |t|
    t.string "name"
    t.string "attribute_cost"
    t.string "relevant_stat"
    t.text "description"
    t.json "level_effects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_per_level"
  end

  create_table "besm_defects", force: :cascade do |t|
    t.string "name"
    t.string "defect_type"
    t.text "description"
    t.json "rank_effects"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_per_level"
  end

  create_table "character_attributes", force: :cascade do |t|
    t.integer "character_sheet_id", null: false
    t.string "name", null: false
    t.integer "level", default: 1, null: false
    t.integer "points", default: 0, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false, null: false
    t.index ["character_sheet_id", "name"], name: "index_character_attributes_on_character_sheet_id_and_name"
    t.index ["character_sheet_id"], name: "index_character_attributes_on_character_sheet_id"
  end

  create_table "character_defects", force: :cascade do |t|
    t.integer "character_sheet_id", null: false
    t.string "name", null: false
    t.integer "rank", default: 1, null: false
    t.integer "bp", default: 0, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id", "name"], name: "index_character_defects_on_character_sheet_id_and_name"
    t.index ["character_sheet_id"], name: "index_character_defects_on_character_sheet_id"
  end

  create_table "character_point_adjustments", force: :cascade do |t|
    t.integer "character_sheet_id", null: false
    t.integer "points"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_character_point_adjustments_on_character_sheet_id"
  end

  create_table "character_sheets", force: :cascade do |t|
    t.string "character_name", null: false
    t.string "player_name", null: false
    t.string "gm_name"
    t.integer "character_points", default: 0, null: false
    t.string "race"
    t.string "occupation"
    t.string "habitat"
    t.string "size_height_weight_gender"
    t.integer "body", default: 6, null: false
    t.integer "mind", default: 6, null: false
    t.integer "soul", default: 6, null: false
    t.integer "health_points", default: 30, null: false
    t.integer "energy_points", default: 20, null: false
    t.string "damage_multiplier", default: "x2", null: false
    t.text "game_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "money"
    t.integer "melee_acv", default: 6, null: false
    t.integer "ranged_acv", default: 6, null: false
    t.integer "melee_dcv", default: 6, null: false
    t.integer "ranged_dcv", default: 6, null: false
    t.index ["character_name"], name: "index_character_sheets_on_character_name"
    t.index ["player_name"], name: "index_character_sheets_on_player_name"
  end

  create_table "equipment_entries", force: :cascade do |t|
    t.integer "character_sheet_id", null: false
    t.integer "kind", default: 0, null: false
    t.string "name", null: false
    t.string "summary"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points"
    t.boolean "draft", default: false, null: false
    t.index ["character_sheet_id", "kind"], name: "index_equipment_entries_on_character_sheet_id_and_kind"
    t.index ["character_sheet_id"], name: "index_equipment_entries_on_character_sheet_id"
  end

  create_table "money_adjustments", force: :cascade do |t|
    t.integer "character_sheet_id", null: false
    t.integer "amount"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_money_adjustments_on_character_sheet_id"
  end

  create_table "weapon_enhancements", force: :cascade do |t|
    t.string "name"
    t.string "ranks"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_per_level"
  end

  create_table "weapon_limiters", force: :cascade do |t|
    t.string "name"
    t.string "ranks"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost_per_level"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "character_attributes", "character_sheets"
  add_foreign_key "character_defects", "character_sheets"
  add_foreign_key "character_point_adjustments", "character_sheets"
  add_foreign_key "equipment_entries", "character_sheets"
  add_foreign_key "money_adjustments", "character_sheets"
end
