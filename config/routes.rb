Rails.application.routes.draw do
  resources :responses
  resources :demographic_questions
  resources :questions
  devise_for :users

  authenticated :user do
    root 'surveys#index', as: :authenticated_root
  end

  root to: "static_pages#index"

  resources :surveys, param: :uuid

  get 'static_pages/index'
end
