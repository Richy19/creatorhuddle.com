source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'active_model_serializers'

# dev grease
gem 'simple_form'
gem 'cruddy'

# background jobs
gem 'sidekiq'
gem 'whenever', require: false

gem 'premailer-rails'

# sitemap generation
gem 'big_sitemap'

gem 'compass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'

gem 'paperclip' # store images
gem 'paperclip-meta', github: 'y8/paperclip-meta', ref: '321f437f36696d539db1a1853efc0e8e08539b44' # and their meta data
gem 'aws-sdk' # and store them on s3

gem 'will_paginate' # pagination
gem 'will_paginate-bootstrap'

# user auth
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
  gem 'rspec-rails'
end

group :test do
  gem 'poltergeist'
  gem 'fuubar'
  gem 'launchy'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails', '1.1.0'
  gem 'capistrano', '>= 3.0.0'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler', '1.1.1'
  gem 'sepastian-capistrano3-unicorn', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
