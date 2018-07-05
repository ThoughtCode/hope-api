Koala.configure do |config|
  config.app_id = Rails.application.secrets.facebook_api_id
  config.app_secret = Rails.application.secrets.facebook_secret
  config.api_version = "v3.0"
end
