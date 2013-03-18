class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :preload_tasks
  
  disclaimer(:demo) if Disclaimer::Document.table_exists?
  
  private
  def preload_tasks
    get_answer_store
    check_cope_index
  end
  
  def get_answer_store(create_new = false)
    get_qwester_answer_store(create_new)
  end
  
  def get_rule_sets
    @rule_sets = matching_rule_sets || []
    trigger_any_warnings_associated_with_rule_sets
  end
  
  def trigger_any_warnings_associated_with_rule_sets
    @rule_sets.each{|r| Ominous::Warning.trigger(r.warning.name) if r.warning}
  end
  
#  def matching_rule_sets
#    if get_answer_store
#      RuleSet.matching(@qwester_answer_store.answers)
#    end
#  end
  
  def get_questions
    @questions = Question.all
  end
  
  def get_questionnaires
    @questionnaires = current_questionnaires
  end
  
  def extract_questions_from_params
    questions = Array.new
    if params[:questions]
      question_ids = params[:questions][:id]
      question_ids.each do |id, value|
        if value == '1'
          questions << Question.find(id)
        end
      end
    end
    questions.uniq
  end

  def check_cope_index
    if @qwester_answer_store and coping_score_exceeded?
      Ominous::Warning.trigger :coping_index_threashold_exceeded
    end
  end

  def coping_score_exceeded?
    @qwester_answer_store.answers.sum(:cope_index) > Setting.for(:cope_index_threshold)
  end

end
