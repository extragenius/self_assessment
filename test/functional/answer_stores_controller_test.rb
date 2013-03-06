require 'test_helper'

class AnswerStoresControllerTest < ActionController::TestCase
  
  def setup
    @answer_store = AnswerStore.find(1)
    @current_answer_store = AnswerStore.create
  end
  
  
  def test_show
    get :show, {:id => @answer_store.session_id}, {:qwester_answer_store => @current_answer_store.session_id}
    assert_response :success
    assert_equal(@answer_store, assigns('answer_store'))
    assert_equal(@current_answer_store.session_id, session['qwester_answer_store'])
  end
  
  def test_update
    put :update, {:id => @answer_store.session_id}, {:qwester_answer_store => @current_answer_store.session_id}
    assert_response :redirect
    assert_equal(@answer_store.session_id, session['qwester_answer_store'])
  end

  def test_new
    get :new
    assert_response :success
  end
  
  def test_cope_index_sum_with_no_answers
    assert_equal(0, @answer_store.answers.sum(:cope_index))
  end

  def test_cope_index_sum
    @answer_store.answers << Answer.find(1)
    assert_equal(0, @answer_store.answers.sum(:cope_index))
    number = 6
    @answer_store.answers.first.update_attribute(:cope_index, number)
    assert_equal(number, @answer_store.answers.sum(:cope_index))
  end  

end
