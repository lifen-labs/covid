ActiveAdmin.register StandardSurvey do
  actions :index, :show

  controller do
    def scoped_collection
      super.includes :patient
    end
  end

  scope :completed, default: true
  scope :to_complete
  scope :green
  scope :yellow
  scope :orange
  scope :red

  index do
    id_column
    column :patient
    column(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
    column :body_temperature
    column :created_at
    column :completed_at
    actions
  end

  filter :patient_id
  filter :status, as: :select, collection: StandardSurvey.enum_filter_collection('status')
  filter :body_temperature
  filter :cohabitants_recent_change
  filter :breathing_difficulty_borg_scale
  filter :heartbeats_per_minute
  filter :recent_faintness
  filter :agreed_containment
  filter :respiratory_rate_in_cycles_per_minute
  filter :recent_cold_chill
  filter :completed_at
  filter :created_at

  action_item(:edit_standard_survey, only: :show) do
    link_to 'Remplir le formulaire', standard_survey.temporary_url, target: '_blank'
  end

  sidebar "Informations principales", only: :show do
    attributes_table_for standard_survey do
      row(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
    end

    attributes_table_for standard_survey, :patient, :created_at, :completed_at
  end

  show title: :to_s do
    columns do
      column do
        panel "Questionnaire précédent" do
          if standard_survey.previous_completed_standard_survey
            attributes_table_for standard_survey.previous_completed_standard_survey do
              row(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
            end

            attributes_table_for standard_survey.previous_completed_standard_survey, :body_temperature, :cohabitants_recent_change, :breathing_difficulty_borg_scale, :heartbeats_per_minute, :respiratory_rate_in_cycles_per_minute, :recent_faintness, :recent_cold_chill, :agreed_containment, :agreed_containment_comment, :created_at, :completed_at
          end
        end
      end
      column do
        panel "Réponses" do
          attributes_table_for standard_survey, :body_temperature, :cohabitants_recent_change, :breathing_difficulty_borg_scale, :heartbeats_per_minute, :respiratory_rate_in_cycles_per_minute, :recent_faintness, :recent_cold_chill, :agreed_containment, :agreed_containment_comment
        end
      end
    end

    panel "Questionnaires standards du patient" do
      table_for(standard_survey.patient.standard_surveys.order(created_at: :desc)) do
        column('') { |standard_survey| standard_survey }
        column(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
        column :body_temperature
        column :created_at
        column :completed_at
      end
    end
  end
end
