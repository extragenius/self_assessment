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
gem "ckeditor", "3.7.2"   # Adds rich text editor to input fields

gem 'devise'         # Authentication
gem 'activeadmin'    # Admin interface

gem 'dibber'  # Used in db/seeds to handle data retrieval from yml files

gem 'i18n-js'  # Allows translation files to be used within JavaScript

gem 'acts_as_list' # Added to allow questions to be ordered within questionnaires

#gem 'ominous', :path => "~/web/ominous" 
gem 'ominous', '~> 0.0.5'

gem(
  'i18n-active_record',
  :path => File.expand_path("../vendor/local_gem_store/", __FILE__),
  :require => 'i18n/active_record'
) # Allows translations to be stored in database

gem 'jasmine', :group => [:development, :test] # JavaScript test environment

gem 'lazy_high_charts' # High charts plugin: creates graphs via JavaScript

#gem 'qwester', :path => '~/web/qwester'
gem 'qwester', "~> 0.1.3"  # Adds questionnaires, questions, answers and rule sets.

#gem 'disclaimer', :path => '~/web/Disclaimer'
gem 'disclaimer' # Used for 'this is a test site disclaimer

gem 'prawn'  # PDF generation

# gem 'mournful_settings', :path => '~/web/mournful_settings'
gem 'mournful_settings', '~> 0.1.0'   # Provides settings functionality

