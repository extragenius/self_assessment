require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @question = Question.find(1)
    sign_in_admin_user
  end
  
  def test_index
    get :index
    assert_response :success
    assert_equal(Question.all, assigns('questions'))
  end

  def test_show
    get :show, :id => @question.id
    assert_response :success
    assert_equal(@question, assigns('question'))
  end

  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    title = 'New question'
    assert_difference 'Question.count' do
      post :create, :question => {:title => title}
    end
    assert_response :redirect
    assert_equal(title, Question.last.title)
  end

  def test_edit
    get :edit, :id => @question.id
    assert_response :success
    assert_equal(@question, assigns('question'))
  end
  
  def test_update
    title = 'Another question'
    post :update, :id => @question.id, :question => {:title => title}
    assert_equal(title, @question.reload.title)
    assert_response :redirect
  end

  def test_delete
    get :delete, :id => @question.id
    assert_response :success
    assert_equal(@question, assigns('question'))
  end
  
  def test_destroy
    assert_difference 'Question.count', -1 do
      delete :destroy, :id => @question.id
    end
  end

end
