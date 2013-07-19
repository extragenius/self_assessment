require_relative '../test_helper'

class RuleSetTabsTest <  ActionDispatch::IntegrationTest

  def setup
    @questionnaire = Questionnaire.find(1)
    @question = Question.find(1)
    @answer = @question.answers.first
  end

  def test_rule_set_displayed
    update_questionnaire
    @rule_set = RuleSet.first
    @rule_set.answers << @qwester_answer_store.answers.first
    @rule_set.save

    @rule_set_id = "rule_set_#{@rule_set.id}"

    get 'questionnaires'
    assert_equal([@rule_set], assigns['rule_sets'])
    assert_tag(tag: 'div', attributes: {id: @rule_set_id})
  end


  def test_hide_tab
    test_rule_set_displayed
    post ['rule_sets', @rule_set_id, 'hide_tab'].join('/')
    get 'questionnaires'
    assert_no_tag(tag: 'div', attributes: {id: @rule_set_id})
  end

  def update_questionnaire
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
    assert_equal(@question, @answer.question)
    assert_equal([@answer], @qwester_answer_store.answers)
  end


end
