Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'surveys#index', as: :authenticated_root
  end

  root to: "static_pages#index"

  resources :surveys
  get 'static_pages/index'
end
