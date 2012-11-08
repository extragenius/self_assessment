require_relative '../test_helper'

class RuleSetsControllerTest < ActionController::TestCase

  def setup
    @rule_set = RuleSet.find(1)
    sign_in_admin_user
  end
  
  def test_index
    get :index
    assert_response :success
    assert_equal(RuleSet.all, assigns('rule_sets'))
  end

  def test_show
    get :show, :id => @rule_set.id
    assert_response :success
    assert_equal(@rule_set, assigns('rule_set'))
  end

  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    title = 'New rule_set'
    answer = Answer.find(1)
    question = answer.question
    other_question = Question.find(2)
    assert_not_equal(question, other_question)
    
    assert_difference 'RuleSet.count' do
      post(
        :create, 
        :rule_set => {
          :title => title,
          :url => 'http://undervale.co.uk'
        },
        :questions => {
          :id => {
            question.id.to_s.to_sym => '1'
          }
        },
        :answers => {
          :question_id => {
            question.id.to_s.to_sym => answer.value,
            other_question.id.to_s.to_sym => 'No'
          }
        }
      )
    end
    assert_response :redirect
    rule_set = RuleSet.last
    assert_equal(title, rule_set.title)
    assert_equal([answer], rule_set.answers)
  end

  def test_edit
    get :edit, :id => @rule_set.id
    assert_response :success
    assert_equal(@rule_set, assigns('rule_set'))
  end
  
  def test_update
    title = 'Another rule_set'
    post :update, :id => @rule_set.id, :rule_set => {:title => title}
    assert_equal(title, @rule_set.reload.title)
    assert_response :redirect
  end

  def test_delete
    get :delete, :id => @rule_set.id
    assert_response :success
    assert_equal(@rule_set, assigns('rule_set'))
  end
  
  def test_destroy
    assert_difference 'RuleSet.count', -1 do
      delete :destroy, :id => @rule_set.id
    end
  end


end
