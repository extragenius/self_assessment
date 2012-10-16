require_relative '../test_helper'

class RuleSetTest < ActiveSupport::TestCase
  def setup
    @rule_set = RuleSet.find(1)
    @answer = Answer.find(1)
    @other_answer = Answer.find(2)
    @rule_set.answers << @answer
  end
  
  def test_match
    assert(@rule_set.match(@rule_set.answers), "should match if rule_set.answers equal answers passed in")
  end
  
  def test_match_when_additional_answers_passed_in
    assert(@rule_set.match([@rule_set.answers, @other_answer].flatten), "should match as long as answers passed in include ruleset.answers")
  end
  
  def test_match_failure
    assert_no_rule_set_match([@other_answer])
  end
  
  def test_partial_match
    @rule_set.answers << @other_answer
    assert_no_rule_set_match([@other_answer])
  end
  
  def test_match_when_no_answers_passed_in
    assert_no_rule_set_match([])
  end
  
  def test_match_when_nil_passed_in
    assert_no_rule_set_match(nil)
  end
  
  def test_matches
    create_more_rule_sets
    rule_sets = RuleSet.matching([@answer])
    assert_equal(2, rule_sets.length)
    assert(rule_sets.include?(@rule_set), "RuleSet @rule_set should be included")
    assert(rule_sets.include?(@rule_set_one), "RuleSet one should be included")
    assert(!rule_sets.include?(@rule_set_two), "RuleSet two should not be included")
  end
  
  def test_matchs_with_where
    create_more_rule_sets
    rule_sets = RuleSet.where(:title => @rule_set.title).matching([@answer])
    assert_equal([@rule_set], rule_sets)
  end
  
  def test_current_value_for
    assert_equal(@answer.value, @rule_set.value_for(@answer.question))
  end
  
  def test_current_value_for_when_no_matching_answer
    question = Question.create(:title => 'test for current value for')
    assert_nil(@rule_set.value_for(question))
  end
  
  private
  def assert_no_rule_set_match(answers = nil)
    assert_nil(@rule_set.match(answers), "should return nil if no match found")
  end
  
  def create_more_rule_sets
    @rule_set_one = RuleSet.create(:title => 'One', :answers => [@answer], :url => 'http://undervale.co.uk')
    @rule_set_two = RuleSet.create(:title => 'Two', :answers => [@other_answer], :url => 'http://undervale.com')
  end
  
end
