class AddRefToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ref, :string
  end
end
