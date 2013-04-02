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
  
  def test_show_without_valid_session_id
    get :show, {:id => 'something else'}, {:qwester_answer_store => @current_answer_store.session_id}
    assert_response :redirect
    assert_match('Unable to retrieve previous answers', flash[:alert])
  end
  
  def test_update
    assert_difference 'Qwester::AnswerStore.count' do
      put :update, {:id => @answer_store.session_id}, {:qwester_answer_store => @current_answer_store.session_id}
    end
    assert_response :redirect
    assert_equal(AnswerStore.last.session_id, session['qwester_answer_store'])
  end

  def test_cope_index_sum_with_no_answers
    assert_equal(0, @answer_store.answers.collect(&:cope_index).sum)
    assert_equal(@answer_store.answers.sum(:weighting), @answer_store.answers.collect(&:cope_index).sum)
  end

  def test_cope_index_sum
    @answer_store.answers << Answer.find(1)
    number = 6
    @answer_store.answers.first.update_attribute(:weighting, number)
    assert_equal(number, @answer_store.answers.collect(&:cope_index).sum)
    assert_equal(@answer_store.answers.sum(:weighting), @answer_store.answers.collect(&:cope_index).sum)
  end  

end
