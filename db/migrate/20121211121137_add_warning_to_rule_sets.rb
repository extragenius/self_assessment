class AddWarningToRuleSets < ActiveRecord::Migration
  def change
    add_column :rule_sets, :warning_id, :integer
  end
end
