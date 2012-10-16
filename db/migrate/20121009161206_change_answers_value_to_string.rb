class ChangeAnswersValueToString < ActiveRecord::Migration
  def up
    change_column(:answers, :value, :string)
  end

  def down
    change_column(:answers, :value, :boolean)
  end
end
