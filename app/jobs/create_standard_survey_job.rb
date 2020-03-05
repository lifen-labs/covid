class CreateStandardSurveyJob < ApplicationJob
  def perform
    selected_patients.includes(:standard_surveys).find_each do |patient|
      next unless patient.needs_a_new_standard_survey? # TODO: find a clever JOIN sql query to avoid ugly N+1 queries, will hold for now (async job)

      safely_create_standard_survey(patient)
    end
  end

  private

    def selected_patients
      Patient.active
    end

    def safely_create_standard_survey(patient)
      Raven.extra_context(patient_id: patient.id)

      CreateStandardSurveyForm.new(patient: patient).submit!
    rescue StandardError => e
      Raven.capture_exception(e)
    end

end
