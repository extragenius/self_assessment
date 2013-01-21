class MoveTablesToQwesterVersions < ActiveRecord::Migration
  def change
    
    tables = %w{
      answer_stores
      answer_stores_answers
      answer_stores_questionnaires    
      answers 
      answers_rule_sets
      questionnaires
      questionnaires_questions
      questions    
      rule_sets
    }
    
    tables.each do |table|
      rename_table table, "qwester_#{table}"
    end
    
  end


end
