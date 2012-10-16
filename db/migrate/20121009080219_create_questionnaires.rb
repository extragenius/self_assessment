class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
    
    create_table :questionnaires_questions, :id => false do |t|
      t.integer :questionnaire_id
      t.integer :question_id
    end
  end
end
