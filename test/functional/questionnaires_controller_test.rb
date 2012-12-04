require_relative '../test_helper'

class QuestionnairesControllerTest < ActionController::TestCase
  def setup
    @questionnaire = Questionnaire.find(1)
    @question = Question.find(1)
  end
  
  def test_setup
    assert_equal(2, @question.answers.count)
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
    answer = @question.answers.first
    assert_difference 'AnswerStore.count' do
      put(
        :update,
        :id => @questionnaire.id,
        :question_id => {
          @question.id.to_s => {
            :answer_ids => [answer.id.to_s]
          }
        }
      )
    end
    @answer_store = AnswerStore.last
    assert_equal(@question, answer.question)
    assert_equal([answer], @answer_store.answers)
    assert_equal(session[:answer_store], @answer_store.session_id)
    assert_response :redirect
  end
  
  def test_update_add_multiple_answers
    answer = @question.answers.first
    other_question = Question.find(2)
    other_question.create_standard_answers
    other_answer = other_question.answers.last
    assert_difference 'AnswerStore.count' do
      put(
        :update,
        :id => @questionnaire.id,
        :question_id => {
          @question.id.to_s => {
            :answer_ids => [answer.id.to_s]
          },
          other_question.id.to_s => {
            :answer_ids => [other_answer.id.to_s]
          }
        }
      )
    end
    @answer_store = AnswerStore.last

    assert_equal([answer, other_answer], @answer_store.answers)
  end
  
  def test_update_add_multiple_answers_for_same_question
    answer, other_answer = @question.answers[0..1]
    assert_not_equal(answer, other_answer)
    assert_difference 'AnswerStore.count', 1 do
      put(
        :update,
        :id => @questionnaire.id,
        :question_id => {
          @question.id.to_s => {
            :answer_ids => [answer.id.to_s, other_answer.id.to_s]
          }
        }
      )
    end
    @answer_store = AnswerStore.last

    assert_equal([answer, other_answer], @answer_store.answers)
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
      assert_equal([], @answer_store.reload.questionnaires)
    end
  end
  
  def test_update_adds_questionnaire_to_answer_store
    test_update
    assert_equal([@questionnaire], @answer_store.questionnaires)
  end

end
