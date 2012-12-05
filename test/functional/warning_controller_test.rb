require 'test_helper'

class WarningControllerTest < ActionController::TestCase

  def test_update
    put :update, :id => 'cope_index', :set => 'hide'
    assert_equal('hide', session[:warning_cope_index])
  end

end
