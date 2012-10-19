require_relative '../test_helper'

class QuestionnairesControllerTest < ActionController::TestCase
  def setup
    @questionnaire = Questionnaire.find(1)
    @question = Question.find(1)
  end
  
  def test_index
    get :index
    assert_response :success
    assert_equal(Questionnaire.all, assigns('questionnaires'))
  end

  def test_show
    get :show, :id => @questionnaire.id
    assert_response :success
    assert_equal(@questionnaire, assigns('questionnaire'))
  end

  def test_new
    get :new
    assert_response :success
    assert_equal(Question.all, assigns('questions'))
  end
  
  def test_create
    title = 'New questionnaire'
    assert_difference 'Questionnaire.count' do
      post(
        :create, 
        :questionnaire => {
          :title => title
        },
        :questions => {
          :id => {
            @question.id.to_s.to_sym => '1'
          }
        }
      )
    end
    assert_response :redirect
    questionnaire = Questionnaire.last
    assert_equal(title, questionnaire.title)
    assert_equal([@question], questionnaire.questions)
  end

  def test_edit
    get :edit, :id => @questionnaire.id
    assert_response :success
    assert_equal(@questionnaire, assigns('questionnaire'))
  end
  
  def test_update
    title = 'Another questionnaire'
    post(
      :update, 
      :id => @questionnaire.id, 
      :questionnaire => {
        :title => title
      },
      :questions => {
        :id => {
          @question.id.to_s.to_sym => '1'
        }
      }
    )
    @questionnaire.reload
    assert_equal(title, @questionnaire.title)
    assert_equal([@question], @questionnaire.questions)
    assert_response :redirect
  end
  
  def test_update_removes_unselected_questions
    @questionnaire.questions = [Question.find(2)]
    test_update
  end

  def test_delete
    get :delete, :id => @questionnaire.id
    assert_response :success
    assert_equal(@questionnaire, assigns('questionnaire'))
  end
  
  def test_destroy
    assert_difference 'Questionnaire.count', -1 do
      delete :destroy, :id => @questionnaire.id
    end
  end
  
  def test_answer
    assert_difference 'Answer.count' do
      assert_difference 'AnswerStore.count' do
        post(
          :answer,
          :id => @questionnaire.id,
          :answers => {
            :question_id => {
              @question.id.to_s.to_sym => 'Yes'
            }
          }
        )
      end
    end
    answer = Answer.last
    @answer_store = AnswerStore.last
    assert_equal(@question, answer.question)
    assert_equal([answer], @answer_store.answers)
    assert_equal(session[:answer_store], @answer_store.session_id)
    assert_response :redirect
  end
  
  def test_reset
    test_answer
    assert_no_difference 'Answer.count' do
      get :reset
      assert_response :redirect
      assert_equal([], @answer_store.reload.answers)
    end
  end

end
