class RuleSetsController < ApplicationController
  
  layout 'tab_content'
  
  def show
    @rule_set = RuleSet.find(params[:id])
    @answers = @rule_set.answers & @qwester_answer_store.answers
  end

  def hide_tab
    if params[:id] and /\d+/.match(params[:id])
      rule_set_id = Regexp.last_match(0)
      rule_sets_to_hide << rule_set_id if RuleSet.exists?(rule_set_id)
    end
    render text: 'gone'
  end
  
end
