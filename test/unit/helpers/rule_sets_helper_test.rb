require 'test_helper'

class RuleSetsHelperTest < ActionView::TestCase
  
  def setup
    @answer = Answer.find(1)
    @rule_set = RuleSet.find(1)
  end
  
  def test_question_summary
    expected = "<strong>#{@answer.value}</strong> <em>to :-</em> #{@answer.question.title}"
    assert_equal(expected, question_summary(@answer))
  end

  def test_link_to_rule_set_url
    link = link_to_rule_set_url(@rule_set)
    assert_match(Regexp.new("href=\"#{@rule_set.url}\""), link)
    assert_no_match(/\>#{@rule_set.url}\</, link)
    assert_match(/\>.{10,}\</, link)
  end

  def test_link_to_rule_set_url_when_link_text_present
    @rule_set.link_text = "this link"
    link = link_to_rule_set_url(@rule_set)
    assert_match(Regexp.new("href=\"#{@rule_set.url}\""), link)
    assert_match(/\>#{@rule_set.link_text}\</, link)
  end
  
end
