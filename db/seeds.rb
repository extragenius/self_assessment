Seeder = Dibber::Seeder

Seeder.seeds_path = "#{Rails.root}/db/seeds"

Seeder.monitor Questionnaire
Seeder.monitor Question
Seeder.monitor Answer
Seeder.monitor RuleSet
Seeder.process_log.start('first questionnaire questions', 'Questionnaire.count > 0 ? Questionnaire.first.questions.length : 0')

if Questionnaire.count > 2
  puts "**** Bypassing questionnaire, question, answer and rule set population"
  puts "**** as there are already #{Questionnaire.count} questionnaires in the system"
else
  Seeder.objects_from('questions.yml').each do |holder, data|
    questionnaire = Questionnaire.find_or_create_by_title(data['title'])

    if data['questions']
      data['questions'].values.each do |question_data|
        question = Question.find_or_create_by_title(question_data['question'])
        question.create_standard_answers
        answer = question.answers.find_or_create_by_value('Yes')
        rule_set = RuleSet.find_or_initialize_by_title(question_data['title'])
        rule_set.url = question_data['url']
        rule_set.answers = [answer]
        rule_set.save
        questionnaire.questions << question
      end
    end
  end
end

Seeder.monitor AdminUser
admin_email = 'admin@warwickshire.gov.uk'
password = 'ChangeMeNow!'
AdminUser.create!(
  :email => admin_email,
  :password => password,
  :password_confirmation => password
) unless AdminUser.exists?(:email => admin_email)

Seeder.new(Setting, 'settings.yml').build

Seeder.monitor Ominous::Warning
Seeder.monitor Ominous::Closer
Seeder.monitor Ominous::WarningCloser
Seeder.objects_from("ominous/warnings.yml").each do |warning, closers|
  warning = Ominous::Warning.find_or_create_by_name(warning)
  
  closers.each do |name, attributes|
    closer = Ominous::Closer.find_or_initialize_by_name(name)
    closer.update_attributes(attributes)
    warning.closers << closer unless warning.closers.include? closer
  end
  
end

unless Disclaimer::Document.exists?
  Seeder.new(Disclaimer::Document, 'disclaimer/documents.yml').build
end

Seeder.new(Guide, 'guides.yml').build unless Guide.exists?

puts Seeder.report