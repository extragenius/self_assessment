require 'test_helper'

class RuleSetsControllerTest < ActionController::TestCase
  def setup
    @rule_set = RuleSet.find(1)
  end

  def test_show
    get :show, :id => @rule_set.id
    assert_response :success
    assert_equal(@rule_set, assigns('rule_set'))
  end

end
