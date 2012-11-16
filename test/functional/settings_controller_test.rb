require 'test_helper'

class SettingsControllerTest < ActionController::TestCase

  def setup
    @setting = Setting.find(1)

  end

  def test_should_get_show
    get :show, :id => @setting.name
    assert_response :success
    assert_equal(@setting.value.to_s, response.body)
  end

  def test_failure_to_get_show
    get :show, :id => :unknown
    assert_response :success
  end

end
