ActiveAdmin.register CommandCenter do
  permit_params :name, :city, :phone_number

  index do
    id_column
    column :name
    column :city
    column :phone_number
    column :created_at
    actions
  end

  filter :name
  filter :city
  filter :phone_number
  filter :created_at
end
