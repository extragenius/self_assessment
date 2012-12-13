require 'test_helper'

class AnswerStoresControllerTest < ActionController::TestCase
  
  def setup
    @answer_store = AnswerStore.find(1)
    @current_answer_store = AnswerStore.create
  end
  
  
  def test_show
    get :show, {:id => @answer_store.session_id}, {:answer_store => @current_answer_store.session_id}
    assert_response :success
    assert_equal(@answer_store, assigns('answer_store'))
    assert_equal(@current_answer_store.session_id, session['answer_store'])
  end
  
  def test_update
    put :update, {:id => @answer_store.session_id}, {:answer_store => @current_answer_store.session_id}
    assert_response :redirect
    assert_equal(@answer_store.session_id, session['answer_store'])
  end

  def test_new
    get :new
    assert_response :success
  end

end
