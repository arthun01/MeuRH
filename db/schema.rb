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

ActiveRecord::Schema[8.1].define(version: 2026_05_24_170730) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.boolean "active"
    t.string "cnpj"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.integer "age"
    t.decimal "bonus_salary", precision: 10, scale: 2
    t.bigint "company_id", null: false
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "discarded_at"
    t.string "name"
    t.bigint "role_id", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["discarded_at"], name: "index_employees_on_discarded_at"
    t.index ["role_id"], name: "index_employees_on_role_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_messages_on_company_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.decimal "base_salary", precision: 10, scale: 2
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_roles_on_company_id"
  end

  create_table "task_assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "employee_id", null: false
    t.bigint "task_id", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_task_assignments_on_employee_id"
    t.index ["task_id"], name: "index_task_assignments_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.text "description"
    t.date "due_date"
    t.integer "status", default: 0
    t.string "tags", default: [], array: true
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_tasks_on_company_id"
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "roles"
  add_foreign_key "employees", "users"
  add_foreign_key "messages", "companies"
  add_foreign_key "messages", "users"
  add_foreign_key "roles", "companies"
  add_foreign_key "task_assignments", "employees"
  add_foreign_key "task_assignments", "tasks"
  add_foreign_key "tasks", "companies"
  add_foreign_key "tasks", "users", column: "creator_id"
end
