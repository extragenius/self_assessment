module Qwester

  ActiveAdmin.register Answer do
    
    index do
      column :id
      column :value
      column 'Question (edit answer via question)', :question do |answer|
        link_to(answer.question.title, edit_admin_qwester_question_path(answer.question)) if answer.question
      end
      column :cope_index
      column :position
      default_actions
    end    
    
  end
  
end
