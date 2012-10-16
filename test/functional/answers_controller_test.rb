require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  
  def setup
    @answer_store = AnswerStore.find(1)
    @answer_store.save
    @answer = Answer.find(1)
    @rule_set = RuleSet.find(1)
    @answer_store.answers << @answer
  end

  def test_index
    get :index
    assert_response :success
  end
  
  def test_index_when_no_answer_store
    test_index
    assert_equal([], assigns('rule_sets'))
  end
  
  def test_index_with_answer_store_in_session
    get :index, {}, {:answer_store => @answer_store.session_id}
    assert_response :success
    assert_equal(@answer_store, assigns('answer_store'))
  end
  
  def test_index_with_answer_store_in_session_and_matching_rule_set
    @rule_set.answers << @answer
    test_index_with_answer_store_in_session
    assert_equal([@rule_set], assigns('rule_sets'))
  end
  
  private

end
