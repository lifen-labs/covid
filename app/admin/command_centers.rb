ActiveAdmin.register CommandCenter do
  permit_params :name, :city

  index do
    id_column
    column :name
    column :city
    column :created_at
    actions
  end

  filter :name
  filter :city
  filter :created_at
end
