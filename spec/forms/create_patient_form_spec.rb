require 'rails_helper'

RSpec.describe CreatePatientForm, type: :model do

  let(:patient)           { build_stubbed :patient }

  let(:first_name)        { patient.first_name }
  let(:last_name)         { patient.last_name }
  let(:cellphone_number)  { patient.cellphone_number }

  let(:attributes) do
    {
      first_name: first_name,
      last_name: last_name,
      cellphone_number: cellphone_number
    }
  end

  let(:form) { CreatePatientForm.new(attributes) }

  context 'with valid attributes' do
    it 'creates a Patient' do
      expect {
        form.submit
      }.to change(Patient, :count).by(1)

      patient = form.patient

      expect(patient.first_name).to eq first_name
    end
  end

  context 'when first_name is missing' do
    let(:first_name) { nil }

    it 'prevents the creation' do
      expect {
        form.submit
      }.to_not change(Patient, :count)
    end
  end
end
