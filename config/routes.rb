Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  devise_for :managers, ActiveAdmin::Devise.config
  devise_for :customers
  devise_for :agents
  ActiveAdmin.routes(self)
  root 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      match '/*all',
            to: 'api#cors_default_options_check',
            constraints: { method: 'OPTIONS' }, via: [:options]
      get '/ping' => 'api#ping'

      # Devise Mapping
      namespace :agents do
        resources :jobs, only: [:index, :show, :accepted, :completed] do
          resources :proposals, only: [:create, :destroy]
        end
        get 'proposals', to: 'proposals#index'
        devise_scope :agent do
          post 'signup', to: 'registrations#create'
          post 'signin', to: 'sessions#create'
          delete 'signout', to: 'sessions#destroy'
          # Passwords
          post 'forgot_password', to: 'passwords#create', as: :forgot_password
          post 'update_password', to: 'passwords#update', as: :update_password
          
          # Recover password for the app
          post 'recover_password', to: 'passwords#app_recover_password', as: :app_recover_password
          post 'app_update_password', to: 'passwords#app_update_password', as: :app_update_password

          put 'update', to: 'agents#update'
        end
        resources :reviews, only: [:index, :show, :create]
        
      end

      
      namespace :customers do
        get 'current', to: 'customers#current'
        put 'change_password', to: 'customers#change_password'
        resources :properties, except: [:new, :edit]
        resources :jobs, except: [:new, :edit] do
          resources :proposals, only: [:show]
          get 'accepted/:id', to: 'proposals#accepted'
          get 'refused/:id', to: 'proposals#refused'
        end
        resources :service_types, only: [:index, :show] do
          resources :services, only: [:index]
        end

        resources :cities, only: [:index] do
          resources :neightborhoods, only: [:index]
        end

        devise_scope :customer do
          post 'signup', to: 'registrations#create'
          post 'facebook', to: 'providers#facebook'
          post 'signin', to: 'sessions#create'
          delete 'signout', to: 'sessions#destroy'
          # Passwords
          post 'forgot_password', to: 'passwords#create', as: :forgot_password
          post 'update_password', to: 'passwords#update', as: :update_password

          #Recover password for the app
          post 'recover_password', to: 'passwords#app_recover_password', as: :app_recover_password
          post 'app_update_password', to: 'passwords#app_update_password', as: :app_update_password

          put 'update', to: 'customers#update'
        end

        resources :reviews, only: [:index, :show, :create]
      end
    end
  end
end
