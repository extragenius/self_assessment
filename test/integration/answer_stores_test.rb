require_relative '../test_helper'

class AnswerStoresTest < ActionDispatch::IntegrationTest
  
  def setup
    @questionnaire = Questionnaire.find(1)
    @other_questionnaire = Questionnaire.find(2)
    @question = Question.find(1)
    @answer = @question.answers.first
    @other_question = Question.find(2)
    @other_question.create_standard_answers
    @other_answer = @other_question.answers.last
  end
  
  def test_single_questionnaire_input
    assert_difference 'AnswerStore.count' do
      put(
        "questionnaires/#{@questionnaire.id}",
        :question_id => {
          @question.id.to_s => {
            :answer_ids => [@answer.id.to_s]
          }
        }
      )
    end
    @qwester_answer_store = AnswerStore.last
    assert_equal([@answer], @qwester_answer_store.answers)
    assert_equal(session[:qwester_answer_store], @qwester_answer_store.session_id)
  end
  
  def test_multiple_questionnaire_inputs
    test_single_questionnaire_input
    assert_no_difference 'AnswerStore.count' do
      put(
        "questionnaires/#{@other_questionnaire.id}",
        :question_id => {
          @other_question.id.to_s => {
            :answer_ids => [@other_answer.id.to_s]
          }
        }
      )
    end 
    @qwester_answer_store.reload
    assert_equal([@answer, @other_answer], @qwester_answer_store.answers, "answer_store should contain answers for both questionnaire submissions")
  end
  
  
end
