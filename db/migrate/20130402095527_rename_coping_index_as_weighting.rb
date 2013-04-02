class RenameCopingIndexAsWeighting < ActiveRecord::Migration
  def change
    rename_column :qwester_answers, :cope_index, :weighting
  end
end
