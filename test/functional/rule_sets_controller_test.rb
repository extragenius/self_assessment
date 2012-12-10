require 'test_helper'

class RuleSetsControllerTest < ActionController::TestCase
  def setup
    @rule_set = RuleSet.find(1)
    @answer_store = AnswerStore.find(1)
    @answer = Answer.find(1)
  end

  def test_show
    @answer_store.answers << @answer
    @rule_set.answers << @answer
    get :show, {:id => @rule_set.id}, {:answer_store => @answer_store.session_id}
    assert_response :success
    assert_equal(@rule_set, assigns('rule_set'))
    assert_equal([@answer], assigns('answers'))
  end
  
  def test_show_without_answer_store
    assert_raise NoMethodError do
      get :show, {:id => @rule_set.id}
    end
  end

#  def test_cope_index_warning_not_shown
#    test_show
#    assert(!assigns('display_cope_index_warning'), "coping index warning should not be displayed")
#  end
#
#  def test_coping_index
#    @answer.update_attribute(:cope_index, (cope_index_threshold + 1))
#    test_show
#    assert_equal(true, assigns('display_cope_index_warning'))
#  end
#
#  def test_warning_cope_index_not_set
#    test_show
#    assert_nil(session[:warning_cope_index], "cope_index warning settings should not appear in session")
#  end
#
#  def test_coping_index_not_shown_if_session_set_to_hide
#    @answer.update_attribute(:cope_index, (cope_index_threshold + 1))
#    get :show, {:id => @rule_set.id}, {:warning_cope_index => 'hide', :answer_store => @answer_store.session_id}
#    assert_not_equal(true, assigns('display_cope_index_warning'))
#  end

  def cope_index_threshold
    Setting.for(:cope_index_threshold)
  end

end
