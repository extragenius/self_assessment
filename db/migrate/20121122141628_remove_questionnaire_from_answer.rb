class RemoveQuestionnaireFromAnswer < ActiveRecord::Migration
  def up
    remove_column :answers, :questionnaire_id
  end

  def down
    add_column :answers, :questionnaire_id, :integer
  end
end
