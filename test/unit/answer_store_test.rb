require_relative '../test_helper'

class AnswerStoreTest < ActiveSupport::TestCase
  
  def setup
    @answer_store = AnswerStore.find(1)
    @answer = Answer.find(1)
    @other_answer = Answer.find(2)
  end
  
  def test_answers_empty
    assert_equal([], @answer_store.answers)
  end
  
  def test_session_id_generated_on_creation
    answer_store = AnswerStore.create
    assert_match /^\w*$/, answer_store.session_id
    assert_equal 15, answer_store.session_id.length
  end
  
  def test_add_answer
    @answer_store.add_answer(@answer)
    assert_equal([@answer], @answer_store.answers)
  end
  
  def test_add_answers_does_not_create_duplicates
    @answer_store.add_answer(@answer)
    test_add_answer
  end
  
  def test_add_answer_removes_conflicting_answers_to_same_question
    assert_equal(@answer.question, @other_answer.question)
    @answer_store.add_answer(@other_answer)
    test_add_answer
  end
  
  def test_answer_for
    test_add_answer
    assert_equal(@answer, @answer_store.answer_for(@answer.question))
  end
  
  def test_remove_answer_for
    test_add_answer
    @answer_store.remove_answer_for(@answer.question)
    test_answers_empty
    assert Answer.exists?(@answer.id), '@answer should not be deleted from database'
  end
  
  def test_remove_answer_for_when_no_answer
    assert_nothing_raised do
      @answer_store.remove_answer_for(@answer.question)
    end
    test_answers_empty
  end
end