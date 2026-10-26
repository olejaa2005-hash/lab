Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :teacher do
    resources :lab_work_templates, only: [:index, :new, :create, :show]
    resources :lab_works, only: [:index, :show, :update]
  end

  namespace :student do
    resources :lab_works, only: [:index, :show, :create, :update]
  end
end