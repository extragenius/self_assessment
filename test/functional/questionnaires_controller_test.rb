require_relative '../test_helper'

class QuestionnairesControllerTest < ActionController::TestCase
  def setup
    @questionnaire = Questionnaire.find(1)
    @question = Question.find(1)
    @answer = @question.answers.first
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
  
  def test_show_with_no_answers
    @questionnaire.questionnaires_questions.delete_all
    test_show
  end


  def test_update
    assert_difference 'AnswerStore.count' do
      put(
        :update,
        :id => @questionnaire.id,
        :question_id => {
          @question.id.to_s => {
            :answer_ids => [@answer.id.to_s]
          }
        }
      )
    end
    @qwester_answer_store = AnswerStore.last
    assert_equal(@question, @answer.question)
    assert_equal([@answer], @qwester_answer_store.answers)
    assert_equal(session[:qwester_answer_store], @qwester_answer_store.session_id)
    assert_response :redirect
  end
  
  def test_update_add_multiple_answers
    other_question = Question.find(2)
    other_question.create_standard_answers
    other_answer = other_question.answers.last
    assert_difference 'AnswerStore.count' do
      put(
        :update,
        :id => @questionnaire.id,
        :question_id => {
          @question.id.to_s => {
            :answer_ids => [@answer.id.to_s]
          },
          other_question.id.to_s => {
            :answer_ids => [other_answer.id.to_s]
          }
        }
      )
    end
    @qwester_answer_store = AnswerStore.last

    assert_equal([@answer, other_answer], @qwester_answer_store.answers)
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
    @qwester_answer_store = AnswerStore.last

    assert_equal([answer, other_answer], @qwester_answer_store.answers)
  end  
  
  def test_rule_set_match_after_update
    test_update
    rule_set = RuleSet.first
    rule_set.answers << @qwester_answer_store.answers.first
    rule_set.save
    get :index
    assert_equal([rule_set], assigns['rule_sets'])
  end
  
  def test_reset
    test_update
    assert_no_difference 'Answer.count' do
      get :reset
      assert_response :redirect
      assert_equal([], @qwester_answer_store.reload.answers)
      assert_equal([], @qwester_answer_store.reload.questionnaires)
    end
  end
  
  def test_update_adds_questionnaire_to_answer_store
    test_update
    assert_equal([@questionnaire], @qwester_answer_store.questionnaires)
  end
  
  def test_cope_index_warning_not_shown
    get :index
    assert_warning_is_not_displayed
  end

  def test_coping_index
    RuleSet.first.update_attribute(:rule, 'a1')
    @answer.update_attribute(:cope_index, (cope_index_threshold + 1))
    test_update
    get :index
    assert_warning_displayed
  end

  def test_warning
    warning = Ominous::Warning.find(1)
    rule_set = RuleSet.first
    rule_set.rule = 'a1'
    rule_set.warning = warning
    rule_set.save
    test_update
    get :index
#    p session
    assert_warning_displayed
  end
  
  def test_warning_not_normally_shown
    test_show
    assert_warning_is_not_displayed
  end
  
  private
  def cope_index_threshold
    Setting.for(:cope_index_threshold)
  end
  
  

end
