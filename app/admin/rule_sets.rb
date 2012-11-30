ActiveAdmin.register RuleSet do

  index do
    column :title
    column :answers do |rule_set|
      rule_set.answers.count
    end
    column :rule
    default_actions
  end

  form :partial => 'admin/rule_sets/form'

#  form do |f|
#    f.inputs "Details" do
#      f.input :title
#      f.input :description, :as => :ckeditor, :input_html => { :height => 100, :toolbar => 'Basic' }
#      f.input :url, :as => :url
#      f.input :answers, :as => :check_boxes, :collection => Answer.order(:question_id).collect{|a| ["#{a.value}:- #{a.question.title}", a.id]}
#    end
#    f.buttons
#  end

  show do
    render :template => 'admin/rule_sets/show'
  end
  
end
