ActiveAdmin.register StandardSurvey do
  actions :index, :show

  controller do
    def scoped_collection
      super.includes :patient
    end
  end

  scope "Actions à faire", :action_needed, default: true
  scope "Non répondants à relancer", :action_needed_due_to_lack_of_response
  scope "Actions réalisées", :action_done
  scope "Complétés", :completed
  scope "A compléter",:to_complete
  scope "Vert", :green
  scope "Jaune", :yellow
  scope "Orange", :orange
  scope "Rouge", :red

  index do
    id_column
    column :patient
    column(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
    column :body_temperature
    column :created_at
    column :completed_at
    column :action_done_at
    actions
  end

  filter :patient_id
  filter :status, as: :select, collection: StandardSurvey.enum_filter_collection('status')
  filter :action_needed
  filter :action_done_at
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

  action_item(:action_done, only: :show, if: proc { standard_survey.action_needed? && standard_survey.action_not_done_yet? }) do
    link_to 'Marquer action faite', action_done_admin_standard_survey_path(standard_survey)
  end

  member_action :action_done, method: :get do
    standard_survey = StandardSurvey.find(params[:id])

    standard_survey.update!(action_done_at: DateTime.current)

    redirect_to admin_standard_survey_path(standard_survey), notice: 'Action effectuée'
  end

  sidebar "Informations principales", only: :show do
    attributes_table_for standard_survey, :patient, :created_at, :completed_at, :action_needed, :action_done_at
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
          attributes_table_for standard_survey do
            row(:status) { |standard_survey| status_tag(StandardSurvey.human_enum_name('status', standard_survey.status), class: "standard_survey_status_#{standard_survey.status}") }
          end

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
