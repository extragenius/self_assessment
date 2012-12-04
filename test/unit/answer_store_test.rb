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
  
  def test_cope_index_sum_with_no_answers
    assert_equal(0, @answer_store.cope_index_sum)
  end

  def test_cope_index_sum
    @answer_store.answers = [@answer]
    assert_equal(0, @answer_store.cope_index_sum)
    number = 6
    @answer.update_attribute(:cope_index, number)
    assert_equal(number, @answer_store.cope_index_sum)
  end
end