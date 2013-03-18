class UpdateToWorkWithQwesterPresentations < ActiveRecord::Migration
  def change
    create_table :qwester_presentations do |t|
      t.string :name
      t.string :title
      t.text :description
      t.boolean :default
      t.timestamps
    end
    
    create_table :qwester_presentation_questionnaires do |t|
      t.integer :questionnaire_id
      t.integer :presentation_id
      t.timestamps
    end

    add_column :qwester_rule_sets, :presentation, :string
  end
end
