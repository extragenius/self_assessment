require_relative '../test_helper'

class AnswerTest < ActiveSupport::TestCase
  def setup
    @answer = Answer.find(1)
  end
  
  def test_find_first_or_create
    answer = Answer.find_first_or_create(
      :value => @answer.value,
      :question_id => @answer.question_id
    )
    assert_equal(@answer, answer)
  end
  
  def test_find_first_or_create_when_answer_does_not_exist
    new_value = 'something'
    assert_difference 'Answer.count' do
      answer = Answer.find_first_or_create(
        :value => 'something',       
        :question_id => Question.first.id
      )
    end
    assert_equal(new_value, Answer.last.value)
  end
end
