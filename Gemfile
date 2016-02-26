ruby '2.2.3'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use mysql as the database for Active Record
gem 'mysql2'

gem 'mongoid', '~> 5.1.0'
gem 'bson_ext'

gem 'sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 2.7.2'
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.0.4'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Basic running
gem 'slim'
gem 'bootstrap-sass'

gem 'puma'

gem 'devise'
gem 'omniauth'
gem 'omniauth-bike-index'
gem 'devise-bootstrap-views'
gem 'hashie-forbidden_attributes'

# Store configuration options
gem 'dotenv-rails'


# Authentication
gem 'doorkeeper'
gem 'wine_bouncer'

# Things tied in with Grade and swagger
gem 'kramdown'
gem 'kaminari'
gem 'grape'
gem 'active_model_serializers'
gem 'grape-active_model_serializers'
gem 'grape-swagger'
gem 'api-pagination'
gem 'rack-cors', :require => 'rack/cors'

# Temporarily remote branch because updates, for more info look at
# https://github.com/d4be4st/swagger-ui_rails/pull/13
gem 'swagger-ui_rails', github: 'audionerd/swagger-ui_rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.0', require: false
  gem 'foreman'
  gem 'rerun'
  gem 'vcr'
  gem 'rspec', '~>3.3.0'
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'growl'
  gem 'guard'
  gem 'guard-rspec', '4.2.8'
  gem 'guard-livereload'
end

group :development do 
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do 
  gem 'database_cleaner'
end