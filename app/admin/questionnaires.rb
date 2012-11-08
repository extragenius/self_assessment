ActiveAdmin.register Questionnaire do

  index do
    column :image do |questionnaire|
      image_tag(questionnaire.button_image.url(:thumbnail))
    end
    column :title
    column :questions do |questionnaire|
      questionnaire.questions.count
    end
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :description, :input_html => { :rows => 2 }
      f.input :button_image, :as => :file, :hint => f.template.image_tag(f.object.button_image.url(:link))
      f.input :questions, :as => :check_boxes, :collection => Question.all
    end
    f.buttons
  end

  show do

    div do
      image_tag questionnaire.button_image.url(:link)
    end

    div do
      h3 'Questions'
      ul do
        questionnaire.questions.each do |question|
          li question.title
        end
      end
    end
  end
  
end
