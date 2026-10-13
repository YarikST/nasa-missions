# frozen_string_literal: true

Rails.application.routes.draw do
  root "missions#index"
  resources :missions do
    resources :mission_steps, only: %i[create update destroy], path: :steps
  end

  get "up" => "rails/health#show", as: :rails_health_check

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
end
