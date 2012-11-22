require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  def setup
    @question = Question.find(2)
  end

  def test_setup
    assert_equal(0, @question.answers.count)
  end

  def test_build_default_answers
    assert_no_difference 'Answer.count' do
      @question.build_default_answers
      assert_question_has_default_answers
    end
  end

  def test_create_default_answers
    assert_difference 'Answer.count', Answer.default_values.length do
      @question.create_default_answers
      assert_question_has_default_answers
    end
  end

  private
  def assert_question_has_default_answers
    assert_equal(Answer.default_values, @question.answers.collect(&:value))
  end
end
