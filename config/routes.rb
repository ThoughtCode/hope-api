  Rails.application.routes.draw do
    
    require 'sidekiq/web' unless Rails.env.production?
    mount Sidekiq::Web => '/sidekiq' unless Rails.env.production?

    devise_for :managers, ActiveAdmin::Devise.config
    devise_for :customers
    devise_for :agents

    get 'add_credit_card', to: 'pages#add_card'

    ActiveAdmin.routes(self)
    root 'pages#home'
    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        match '/*all',
        to: 'api#cors_default_options_check',
        constraints: { method: 'OPTIONS' }, via: [:options]
        get '/ping' => 'api#ping'
      post '/contact' => 'api#contact'

      # Devise Mapping
      namespace :agents do
        get 'current', to: 'agents#current'
        get 'notifications', to: 'agents#get_notifications'
        put 'change_password', to: 'agents#change_password'
        get '/jobs/accepted', to: 'jobs#accepted'
        get '/jobs/completed', to: 'jobs#completed'
        get '/jobs/postulated', to: 'jobs#postulated'
        get '/jobs/reports', to: 'jobs#reports'
        get '/jobs/calendar', to: 'jobs#calendar'
        get '/customer/:customer_id/reviews', to: 'reviews#customer_reviews'
        get '/read_notifications/:id', to: 'agents#read_notifications'
        resources :jobs, only: [:index, :show] do
          post 'review', to: 'reviews#create'
          post 'confirm_payment', to: 'jobs#confirm_payment'
          get 'can_review', to: 'jobs#can_review'
          get 'can_apply', to: 'jobs#can_apply'
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
        post 'add_mobile_token', to: 'agents#add_mobile_token'
      end

      namespace :customers do
        get 'holidays', to: 'holidays#index'
        get 'current', to: 'customers#current'
        get 'notifications', to: 'customers#get_notifications'
        put 'change_password', to: 'customers#change_password'
        get '/agent/:agent_id/reviews', to: 'reviews#agent_reviews'
        post '/payments_received', to: 'payments#received'
        post '/payments_update', to: 'payments#update'
        post '/add_card', to: 'payments#add_card'
        post '/add_card_mobile', to: 'payments#add_card_mobile'
        post '/add_transaction', to: 'payments#add_transaction'
        delete '/delete_card/:id', to: 'payments#destroy'
        get 'read_notifications/:id', to: 'customers#read_notifications'
        get 'credit_cards', to: 'payments#index'
        get 'get_user_id', to: 'customers#get_user_id'
        post 'validate_promo_code', to: 'promotions#show'

        resources :invoice_details
        resources :properties, except: [:new, :edit]
        resources :jobs, except: [:new, :edit] do
          get 'completed', to: 'jobs#completed', on: :collection
          get 'current', to: 'jobs#current', on: :collection
          get 'cancelled', to: 'jobs#cancelled'
          post 'review', to: 'reviews#create'
          get 'can_review', to: 'jobs#can_review'
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
        post 'add_mobile_token', to: 'customers#add_mobile_token'
      end
    end
  end
end
