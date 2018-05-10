source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'coffee-rails', '~> 4.2'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.5'
gem 'responders'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Serializers
gem 'fast_jsonapi', '~> 1.1', '>= 1.1.1'

# login System
gem 'devise', '~> 4.4', '>= 4.4.3'

# Admin System
gem 'activeadmin'

# Mailer
gem 'sendgrid-ruby', '~> 5.2'

# Login with facebook
gem 'koala', '~> 3.0'

# Create hashed ids
gem 'bson', '~> 4.3'

gem 'rack-cors', :require => 'rack/cors'

# Upload image
gem 'carrierwave'
gem 'fog'

# Background Jobs
gem 'sidekiq', '~> 5.1', '>= 5.1.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to
  # stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.7'
end

group :test do
  gem 'database_cleaner'
  gem 'faker', '~> 1.8', '>= 1.8.7'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end

group :development do
  # Access an IRB console on exception pages or
  # by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
