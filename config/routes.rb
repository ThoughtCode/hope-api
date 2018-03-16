Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      match '/*all', to: 'api#cors_default_options_check', constraints: { method: 'OPTIONS' }, via: [:options]
      get '/ping' => 'api#ping'


      #Devise Mapping

      devise_scope :user do
        post 'signup', to: 'registrations#create'
        # post 'signin', to: 'sessions#create'
        # delete 'logout', to: 'sessions#destroy'
      end

    end
  end


end
