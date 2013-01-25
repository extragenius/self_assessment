class ChangeRuleSetsDescriptionToBlob < ActiveRecord::Migration
  def up
    change_column :qwester_rule_sets, :description, :text
  end

  def down
    change_column :qwester_rule_sets, :description, :string
  end
end
