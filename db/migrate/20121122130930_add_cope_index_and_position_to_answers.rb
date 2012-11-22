class AddCopeIndexAndPositionToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :position, :integer
    add_column :answers, :cope_index, :integer, :default => 0
  end
end
