if ENV['HOSTNAME'] =~ /wvtcent1\./
  source 'http://wvtcent1/ruby/' 
else
  source 'https://rubygems.org'
end

gem 'rails', '3.2.8'

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
  gem 'capistrano'     # Deployment tool
  gem "better_errors"       # Enhances standard rails error pages
  gem "binding_of_caller"   # Add lists of current variable to better_errors output
end

gem "paperclip", "~> 3.0" # Adds attachment functions
gem "ckeditor", "3.7.2"   # Adds rich text editor to input fields
#gem 'ckeditor_rails'

gem 'devise'         # Authentication
gem 'activeadmin'    # Admin interface

gem 'dibber'  # Used in db/seeds to handle data retrieval from yml files

gem 'i18n-js'  # Allows translation files to be used within JavaScript

gem 'acts_as_list' # Added to allow questions to be ordered within questionnaires

gem 'array_logic', '~> 0.1.0' # Used to identify patterns in RuleSet Answers

# gem 'ominous', :path => "~/web/ominous" 
gem 'ominous', '>= 0.0.3' # Controls the display of warnings

