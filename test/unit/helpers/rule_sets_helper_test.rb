require 'test_helper'

class RuleSetsHelperTest < ActionView::TestCase
  
  def setup
    @answer = Answer.find(1)
  end
  
  def test_question_summary
    expected = "<strong>#{@answer.value}</strong> <em>to :-</em> #{@answer.question.title}"
    assert_equal(expected, question_summary(@answer))
  end
  
end
