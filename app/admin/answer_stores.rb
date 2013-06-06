require 'active_admin_csv_only_fix'

ActiveAdmin.register AnswerStore do

  menu :label => "Answer Stores"

  actions :index

  index :download_links => [:csv] do
    column :questionnairws do |answer_store|
      answer_store.questionnaires.collect{|q| q.title}.join(', ')
    end
    column :answers do |answer_store|
      answer_store.answers.collect{|a| "a#{a.id}"}.join(', ')
    end
    column :created_at
    column :preserved
  end

  csv do
    column :questionnairws do |answer_store|
      answer_store.questionnaires.collect{|q| q.title}.join(', ')
    end
    column :answers do |answer_store|
      answer_store.answers.collect{|a| "a#{a.id}"}.join(', ')
    end
    column :created_at
    column :preserved
  end


end
