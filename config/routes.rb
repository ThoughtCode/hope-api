Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      match '/*all', to: 'api#cors_default_options_check', constraints: { method: 'OPTIONS' }, via: [:options]
      get '/ping' => 'api#ping'
    end
  end
end
