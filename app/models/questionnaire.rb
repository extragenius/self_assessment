class Questionnaire < ActiveRecord::Base
  attr_accessible :title, :description, :button_image, :question_ids
  
  has_and_belongs_to_many(
    :questions,
    :uniq => true
  )
  
  has_attached_file(
    :button_image,
    :styles => {
      :link => '150x125>',
      :thumbnail => '50x50>'
    }
  )
  
  validates :title, :presence => true
  
  
  
end
