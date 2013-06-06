
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :preload_tasks

  def self.disclaimer_name
    if Disclaimer::Document.table_exists?
      disclaimer_names.each do |name|
        if Disclaimer::Document.exists?(:name => name)
          @disclaimer_name = name
          break
        end
      end
    end
    return @disclaimer_name
  end

  def self.disclaimer_names
    [:disclaimer, :main, :one, :wcc, :demo]
  end
  
  disclaimer(disclaimer_name) if disclaimer_name
  
  private
  def preload_tasks
    get_answer_store
  end
  
  def get_answer_store(create_new = false)
    get_qwester_answer_store(create_new)
  end
  
  def get_rule_sets
    @rule_sets = matching_rule_sets || []
    trigger_any_warnings_associated_with_rule_sets
  end
  
  def trigger_any_warnings_associated_with_rule_sets
    begin
      @rule_sets.each{|r| Ominous::Warning.trigger(r.warning.name) if r.warning}
    rescue NoMethodError => e
      unless @reassociated_warning
        reassociate_warning
        retry
      else
        raise e
      end
    end
  end
  
  def reassociate_warning
    Qwester::RuleSet.class_eval do
      belongs_to :warning, :class_name => 'Ominous::Warning'
    end
    @reassociated_warning = true
  end
  
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

end
