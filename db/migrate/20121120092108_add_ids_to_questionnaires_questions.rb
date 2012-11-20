class AddIdsToQuestionnairesQuestions < ActiveRecord::Migration
  def up
    add_column qq_table, :id, :primary_key
    add_column qq_table, :position, :integer
    add_column qq_table, :created_at, :datetime
    add_column qq_table, :updated_at, :datetime
    
    execute "UPDATE questionnaires_questions SET position = id, created_at = now(), updated_at = now()"
  end
  
  def down
    remove_column qq_table, :id
    remove_column qq_table, :position
    remove_column qq_table, :created_at
    remove_column qq_table, :updated_at
  end
  
  def qq_table
    :questionnaires_questions
  end
end
