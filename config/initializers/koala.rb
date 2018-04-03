Koala.configure do |config|
    # config.access_token = MY_TOKEN
    # config.app_access_token = MY_APP_ACCESS_TOKEN
    config.app_id = Rails.application.secrets.facebook_api_id
    config.app_secret = Rails.application.secrets.facebook_secret
    # See Koala::Configuration for more options, including details on how to send requests through
    # your own proxy servers.
    Koala::Facebook::OAuth.new(Rails.application.secrets.facebook_api_id, Rails.application.secrets.facebook_secret, 'localhost:3000').url_for_oauth_code(:permissions => "email")
  end