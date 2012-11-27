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


  def test_update
    assert_difference 'Answer.count' do
      assert_difference 'AnswerStore.count' do
        put(
          :update,
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
  
  def test_rule_set_match_after_update
    test_update
    rule_set = RuleSet.first
    rule_set.answers << @answer_store.answers.first
    rule_set.save
    get :index
    assert_equal([rule_set], assigns['rule_sets'])
  end
  
  def test_reset
    test_update
    assert_no_difference 'Answer.count' do
      get :reset
      assert_response :redirect
      assert_equal([], @answer_store.reload.answers)
    end
  end

end
