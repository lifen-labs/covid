Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :patients, only: [:new, :create]
  resources :standard_surveys, only: [:edit, :update]
end
