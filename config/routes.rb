Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token


  root "sessions#welcome"

  namespace :teacher do
    resources :lab_work_templates
    resources :lab_works, only: %i[index show new create update]
  end

  namespace :student do
    resources :lab_works, only: [:index, :show, :create, :update]
  end
end