class RuleSetsController < ApplicationController
  def show
    @rule_set = RuleSet.find(params[:id])
  end
end
