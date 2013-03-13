class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string  :name
      t.string  :title
      t.text    :summary
      t.text    :details
      t.integer :position
      t.timestamps
    end
  end
end
