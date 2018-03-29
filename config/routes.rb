Rails.application.routes.draw do
  devise_for :managers, ActiveAdmin::Devise.config
  devise_for :customers
  ActiveAdmin.routes(self)
  devise_for :agents
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      match '/*all', to: 'api#cors_default_options_check', constraints: { method: 'OPTIONS' }, via: [:options]
      get '/ping' => 'api#ping'


      #Devise Mapping
      namespace :agents do
        devise_scope :agents do
          post 'signup', to: 'registrations#create'
          post 'signin', to: 'sessions#create'
          delete 'signout', to: 'sessions#destroy'
          # Passwords
          post 'forgot_password', to: 'passwords#create', as: :forgot_password
          post 'update_password', to: 'passwords#update', as: :update_password

          put 'update', to: 'agents#update'
        end
      end

      namespace :customers do
        devise_scope :customer do
          post 'signup', to: 'registrations#create'
          post 'signin', to: 'sessions#create'
          delete 'signout', to: 'sessions#destroy'
          # Passwords
          post 'forgot_password', to: 'passwords#create', as: :forgot_password
          post 'update_password', to: 'passwords#update', as: :update_password

          post 'facebook', to: 'providers#facebook'
          put 'update', to: 'customers#update'
        end
      end
    end
  end
end
