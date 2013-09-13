require 'active_admin_csv_only_fix'

ActiveAdmin.register AnswerStore do

  menu :label => "Answer Stores"

  actions :index

  index :download_links => [:csv] do
    column :questionnaires do |answer_store|
      answer_store.questionnaires.collect{|q| q.title}.join(', ')
    end
    column :answers do |answer_store|
      answer_store.answers.collect{|a| "a#{a.id}"}.join(', ')
    end
    column :created_at
    column :preserved
  end

  csv do
    column :questionnaires do |answer_store|
      answer_store.questionnaires.collect{|q| q.title}.join(', ')
    end
    column :answers do |answer_store|
      answer_store.answers.collect{|a| "a#{a.id}"}.join(', ')
    end
    column :created_at do |answer_store|
      answer_store.created_at.to_s(:google)
    end
    column :preserved do |answer_store|
      answer_store.preserved.to_s(:google) if answer_store.preserved?
    end
  end


end
