class CreateAnswerStoresQuestionnaires < ActiveRecord::Migration
  def change
    
    create_table :answer_stores_questionnaires, :id => false do |t|
      t.integer :questionnaire_id
      t.integer :answer_store_id
    end

  end
end
