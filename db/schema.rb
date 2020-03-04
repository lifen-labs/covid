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

ActiveRecord::Schema.define(version: 2020_03_04_104423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "command_centers", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "cellphone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "otp_secret"
    t.integer "survey_periodicity_in_hours", default: 24
    t.text "address"
    t.string "email"
    t.text "relative_cellphone_number"
    t.text "general_practitioner"
    t.text "covid_general_practitioner"
    t.string "gender"
    t.date "birthdate"
    t.boolean "is_healthcare_professional"
    t.boolean "pregnant"
    t.boolean "home_caregivers"
    t.string "home_caregivers_type"
    t.string "covid_initial_symptom"
    t.date "covid_initial_symptoms_diagnosed_on"
    t.date "covid_initial_symptoms_started_on"
    t.date "covid_treatment_started_on"
    t.boolean "interstitial_alveolus_infiltrates"
    t.text "notable_long_term_treatments"
    t.boolean "sars_cov_2_treatment"
    t.text "sars_cov_2_treatment_name"
    t.boolean "home_follow_up_elligible"
    t.boolean "comorbidity_chronic_cardiac_disease"
    t.boolean "comorbidity_chronic_pulmonary_disease"
    t.boolean "comorbidity_asthma"
    t.boolean "comorbidity_chronic_kidney_disease"
    t.boolean "comorbidity_liver_disease"
    t.boolean "comorbidity_mild_liver_disease"
    t.boolean "comorbidity_chronic_neurological_disorder"
    t.boolean "comorbidity_malignant_neoplasia"
    t.boolean "comorbidity_chronic_hemathological_disease"
    t.boolean "comorbidity_hiv"
    t.boolean "comorbidity_obesity"
    t.boolean "comorbidity_diabetes_with_complications"
    t.boolean "comorbidity_diabetes"
    t.boolean "comorbidity_rheumatologic_disease"
    t.boolean "comorbidity_dementia"
    t.boolean "comorbidity_malnutrition"
    t.string "comorbidity_smoking"
    t.boolean "comorbidity_other"
    t.text "comorbidity_other_comment"
    t.bigint "command_center_id"
    t.integer "pregnant_since_in_weeks"
    t.index ["command_center_id"], name: "index_patients_on_command_center_id"
    t.index ["otp_secret"], name: "index_patients_on_otp_secret", unique: true
  end

  create_table "standard_surveys", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.float "body_temperature"
    t.datetime "completed_at"
    t.string "public_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "cohabitants_recent_change"
    t.integer "breathing_difficulty"
    t.float "breathing_difficulty_borg_scale"
    t.integer "heartbeats_per_minute"
    t.boolean "recent_chest_pain"
    t.boolean "agreed_containment"
    t.text "agreed_containment_comment"
    t.integer "respiratory_rate_in_cycles_per_minute"
    t.boolean "recent_cold_chill"
    t.string "status"
    t.boolean "action_needed", default: false
    t.datetime "action_done_at"
    t.index ["patient_id"], name: "index_standard_surveys_on_patient_id"
    t.index ["public_token"], name: "index_standard_surveys_on_public_token", unique: true
  end

  add_foreign_key "patients", "command_centers"
  add_foreign_key "standard_surveys", "patients"
end
