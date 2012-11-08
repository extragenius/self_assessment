class AnswersController < ApplicationController
  before_filter :get_rule_sets
  
  before_filter :authenticate_admin_user!, :except => [:tabs]
  
  layout 'tabs', :only => [:tabs]
  
  def index
    
  end
  
  def tabs
    get_questionnaires
  end

end
