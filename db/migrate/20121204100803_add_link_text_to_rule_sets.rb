class AddLinkTextToRuleSets < ActiveRecord::Migration
  def change
    add_column :rule_sets, :link_text, :string
  end
end
