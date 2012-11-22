ActiveAdmin.register Answer do

  actions :all, :except => [:edit]

  index do
    column :value
    column 'Question (edit answer via question)', :question do |answer|
      link_to(answer.question.title, edit_admin_question_path(answer.question))
    end
    column :position
    column :cope_index
    default_actions
  end



end
