Rails.application.routes.draw do
  resources :classifications
  resources :demographic_questions, except: [:destroy]
  resources :questions, except: [:destroy]
  devise_for :users

  authenticated :user do
    root 'surveys#index', as: :authenticated_root
  end

  root to: "static_pages#index"

  resources :surveys, param: :uuid do
    resources :responses, param: :uuid
  end

  get 'static_pages/index'
end
