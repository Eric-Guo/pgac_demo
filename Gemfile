source "https://rubygems.org"

ruby ">= 3.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 7.1.2"

gem "sqlite3"

gem "anycable-rails"
gem "redis"

# Use SCSS for stylesheets
gem "sass-rails"

gem "terser"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder"

# Use Puma as the app server
gem "puma"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem "net-smtp", require: false # make test run in ruby 3.1

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  gem "debug"

  gem "standard"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console"
  gem "listen"

  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
  gem "capistrano3-puma", ">= 6.0.0.beta.1"

  gem "ed25519"
  gem "bcrypt_pbkdf"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
