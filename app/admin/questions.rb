ActiveAdmin.register Question do

  index do
    column :ref
    column :title do |question|
      link_to(question.title, '#', :title => question.description, :class => 'no_decoration')
    end
    default_actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :ref, :label => 'Reference'
      f.input :title
      f.input :description, :input_html => { :rows => 2}
    end
    f.buttons
  end
  
  controller do
    
    def move_up
      question = Question.find(params[:id])
      questionnaire = Questionnaire.find(params[:questionnaire_id])
      questionnaire.move_higher(question)
      redirect_to admin_questionnaire_path(questionnaire)
    end
    
    def move_down
      question = Question.find(params[:id])
      questionnaire = Questionnaire.find(params[:questionnaire_id])
      questionnaire.move_lower(question)
      redirect_to admin_questionnaire_path(questionnaire)
    end
    
  end

end
