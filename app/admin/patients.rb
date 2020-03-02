ActiveAdmin.register Patient do
  actions :index, :show

  index do
    id_column
    column :first_name
    column :last_name
    column :cellphone_number
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :cellphone_number
  filter :created_at

  action_item(:new_patient, only: :index) do
    link_to 'Nouveau Patient', new_patient_path
  end
end
