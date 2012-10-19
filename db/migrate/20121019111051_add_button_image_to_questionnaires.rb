class AddButtonImageToQuestionnaires < ActiveRecord::Migration
  def change
    add_attachment :questionnaires, :button_image
  end
end
