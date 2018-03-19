require 'sidekiq/web'

Rails.application.routes.draw do
  resources :classifications, except: [:destroy]
  resources :demographic_questions, except: [:destroy]
  resources :questions, except: [:destroy]
  devise_for :users

  authenticated :user do
    root 'surveys#index', as: :authenticated_root
  end

  root to: "static_pages#index"

  namespace :admin do
    resources :users, controller: "users", except: [:new, :create]
    resources :responses, only: [:index]
  end

  resources :surveys, param: :uuid do
    member do
      post :export
    end

    resources :responses, param: :uuid do
      member do
        get :results
      end
    end
  end

  get 'static_pages/index'
  get 'about-the-project', to: 'static_pages#about_project'
  get 'about-the-debate', to: 'static_pages#about_debate'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["ADMIN_USERNAME"])) &&
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["ADMIN_PASSWORD"]))
  end

  mount Sidekiq::Web, at: "/sidekiq"
end
