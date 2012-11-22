ActiveAdmin.register Question do

  index do
    column :ref
    column :title do |question|
      link_to(question.title, '#', :title => question.description, :class => 'no_decoration')
    end
    column :answers do |question|
      question.answers.count
    end
    default_actions
  end

  show do
    para("References: #{question.ref}") if question.ref.present?
    para(question.description)
    h3 "Answers"
    table do
      tr do
        th 'Value'
      end
      question.answers.each do |answer|
        tr do
          td link_to(answer.value, admin_answer_path(answer))
        end
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :ref, :label => 'Reference'
      f.input :title
      f.input :description, :input_html => { :rows => 2}
    end

    f.has_many :answers do |answer_form|
      answer_form.input :value
      answer_form.input :position
      answer_form.input :cope_index
    end

    f.buttons
  end
  
  controller do

    def new
      @question = Question.new
      @question.build_default_answers
    end
    
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
