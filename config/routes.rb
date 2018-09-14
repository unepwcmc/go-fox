require 'sidekiq/web'

Rails.application.routes.draw do
  resources :classifications, except: [:destroy]
  resources :demographic_questions, except: [:destroy]
  resources :questions, except: [:destroy]
  devise_for :users

  root :to => 'static_pages#index', :constraints => lambda { |request| request.env['warden'].user == nil}
  root :to => 'surveys#index', :constraints => lambda { |request| request.env['warden'].user&.admin == false }
  root :to => 'admin/dashboard#index', :constraints => lambda { |request| request.env['warden'].user&.admin == true }

  namespace :admin do
    root to: "dashboard#index"
    get :support, path: 'support', to: 'dashboard#support'
    get :about_go_fox, path: 'about_go_fox', to: 'dashboard#about_go_fox'
    get :legal, path: 'legal', to: 'dashboard#legal'
    resources :users, controller: "users", except: [:new, :create]
    resources :responses, only: [:index]

    namespace :responses do
      get :export
    end
  end

  resources :surveys, param: :uuid do
    member do
      get :export
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
  get 'support', to: 'static_pages#support'
  get 'legal', to: 'static_pages#legal'
  get 'about-go-fox', to: 'static_pages#about_go_fox'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["ADMIN_USERNAME"])) &&
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["ADMIN_PASSWORD"]))
  end

  mount Sidekiq::Web, at: "/sidekiq"
end
