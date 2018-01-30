Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'surveys#index', as: :authenticated_root
  end

  root to: "static_pages#index"

  resources :surveys, param: :uuid
  # get 'surveys/:uuid', to: 'surveys#show'

  get 'static_pages/index'
end
