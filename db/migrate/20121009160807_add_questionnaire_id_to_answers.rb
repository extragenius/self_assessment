class AddQuestionnaireIdToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :questionnaire_id, :integer
  end
end
