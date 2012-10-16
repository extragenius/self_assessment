class AnswersController < ApplicationController
  before_filter :get_rule_sets
  
  layout 'tabs', :only => [:tabs]
  
  def index
    
  end
  
  def tabs
    get_questionnaires
  end

end
