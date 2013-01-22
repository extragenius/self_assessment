# This migration comes from disclaimer (originally 20121024080818)
class CreateDisclaimerSegmentHolders < ActiveRecord::Migration
  def change
    create_table :disclaimer_segment_holders do |t|
      t.integer :document_id
      t.integer :segment_id
      t.integer :position

      t.timestamps
    end
  end
end
