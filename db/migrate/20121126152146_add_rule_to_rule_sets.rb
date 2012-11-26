class AddRuleToRuleSets < ActiveRecord::Migration
  def change
    add_column :rule_sets, :rule, :text
  end
end
