Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :patients, only: [:new, :create, :edit, :update]
  resources :standard_surveys, only: [:edit, :update, :show] do
    member do
      resources :actions, only: [:new, :create]
    end
  end

  namespace :twilio do
    resources :sms_statuses, only: [:create]
  end
end
