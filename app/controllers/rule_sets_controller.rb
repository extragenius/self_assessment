class RuleSetsController < ApplicationController
  
  def show
    @rule_set = RuleSet.find(params[:id])
    @answers = @rule_set.answers & @qwester_answer_store.answers
  end
  
end
