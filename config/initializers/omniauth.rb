Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_API_ID'], ENV['FACEBOOK_SECRET'],
      scope: 'email, public_profile,user_birthday, user_location, publish_actions, user_friends',
      info_fields: 'email,first_name,last_name,birthday,gender, link, locale, friends'


end