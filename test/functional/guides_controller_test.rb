require 'test_helper'

class GuidesControllerTest < ActionController::TestCase
  
  def setup
    @guide = Guide.find(1)
  end
  
  def test_index
    get :index
    assert_response :success
    assert_equal([@guide], assigns('guides'))
  end

  def test_show
    get :show, :id => @guide.name
    assert_response :success
    assert_equal([@guide], assigns('guides'))
    assert_equal(@guide, assigns('guide'))
  end

end
