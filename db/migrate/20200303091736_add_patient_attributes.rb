class AddPatientAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :address, :text
    add_column :patients, :email, :string
    add_column :patients, :relative_cellphone_number, :text
    add_column :patients, :general_practitioner, :text
    add_column :patients, :covid_general_practitioner, :text
    add_column :patients, :gender, :string
    add_column :patients, :birthdate, :date
    add_column :patients, :is_healthcare_professional, :boolean
    add_column :patients, :pregnant, :boolean
    add_column :patients, :home_caregivers, :boolean
    add_column :patients, :home_caregivers_type, :string
    add_column :patients, :covid_initial_symptom, :string
    add_column :patients, :covid_initial_symptoms_diagnosed_on, :date
    add_column :patients, :covid_initial_symptoms_started_on, :date
    add_column :patients, :covid_treatment_started_on, :date
    add_column :patients, :interstitial_alveolus_infiltrates, :boolean
    add_column :patients, :notable_long_term_treatments, :text
    add_column :patients, :sars_cov_2_treatment, :boolean
    add_column :patients, :sars_cov_2_treatment_name, :text
    add_column :patients, :home_follow_up_elligible, :boolean
  end
end

