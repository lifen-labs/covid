class AddComorbiditiesAttributesToPatients < ActiveRecord::Migration[6.0]
  def change
    add_column :patients, :comorbidity_chronic_cardiac_disease, :boolean, default: nil
    add_column :patients, :comorbidity_chronic_pulmonary_disease, :boolean, default: nil
    add_column :patients, :comorbidity_asthma, :boolean, default: nil
    add_column :patients, :comorbidity_chronic_kidney_disease, :boolean, default: nil
    add_column :patients, :comorbidity_liver_disease, :boolean, default: nil
    add_column :patients, :comorbidity_mild_liver_disease, :boolean, default: nil
    add_column :patients, :comorbidity_chronic_neurological_disorder, :boolean, default: nil
    add_column :patients, :comorbidity_malignant_neoplasia, :boolean, default: nil
    add_column :patients, :comorbidity_chronic_hemathological_disease, :boolean, default: nil
    add_column :patients, :comorbidity_hiv, :boolean, default: nil
    add_column :patients, :comorbidity_obesity, :boolean, default: nil
    add_column :patients, :comorbidity_diabetes_with_complications, :boolean, default: nil
    add_column :patients, :comorbidity_diabetes, :boolean, default: nil
    add_column :patients, :comorbidity_rheumatologic_disease, :boolean, default: nil
    add_column :patients, :comorbidity_dementia, :boolean, default: nil
    add_column :patients, :comorbidity_malnutrition, :boolean, default: nil
    add_column :patients, :comorbidity_smoking, :string
    add_column :patients, :comorbidity_other, :boolean, default: nil
    add_column :patients, :comorbidity_other_comment, :text
  end
end
