ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

end

class ActionController::TestCase
  include Devise::TestHelpers
  
  def sign_in_admin_user
    @admin_user = AdminUser.find(1)
    sign_in @admin_user
  end
  
  def assert_warning_displayed
    assert_tag :tag => "div", :attributes => { :class => "ominous_warnings" }
  end
  
  def assert_warning_is_not_displayed
    assert_no_tag :tag => "div", :attributes => { :class => "ominous_warnings" }
  end
end

