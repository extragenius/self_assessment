if ENV['HOSTNAME'] =~ /wvtcent1\./
  source 'http://wvtcent1/ruby/' 
else
  source 'https://rubygems.org'
end 

gem 'rails', '3.2.13'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-script'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '0.10.2', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  
  gem 'jquery-ui-rails'
  gem 'jquery-rails'
end

group :development do
  gem 'capistrano', '2.13.4'     # Deployment tool
  gem "better_errors"       # Enhances standard rails error pages
  gem "binding_of_caller"   # Add lists of current variable to better_errors output
  gem 'sinatra'
end

gem "paperclip", "~> 3.0" # Adds attachment functions

gem 'devise'         # Authentication
gem 'activeadmin'    # Admin interface

gem 'dibber', "~> 0.2"  # Used in db/seeds to handle data retrieval from yml files

gem 'i18n-js'  # Allows translation files to be used within JavaScript

gem 'acts_as_list' # Added to allow questions to be ordered within questionnaires

#gem 'ominous', :path => "~/web/ominous"
gem 'ominous', '~> 0.1.1'

gem 'jasmine', :group => [:development, :test] # JavaScript test environment

gem 'lazy_high_charts' # High charts plugin: creates graphs via JavaScript

# gem 'qwester', :path => '~/web/qwester'
gem 'qwester', "~> 0.2.2"  # Adds questionnaires, questions, answers and rule sets.

#gem 'disclaimer', :path => '~/web/disclaimer'
gem 'disclaimer', ">= 0.1" # Used for 'this is a test site disclaimer

gem 'prawn'  # PDF generation

# gem 'mournful_settings', :path => '~/web/mournful_settings'
gem 'mournful_settings', '~> 0.1.0'   # Provides settings functionality

gem 'simplecov', :require => false, :group => :test # Test coverage tool

gem 'rack-ssl-enforcer' # allows part of the application to be forced to use a secure connection

gem 'remote_partial', '~> 0.7'  # Used to import and display WCC headers and footers

