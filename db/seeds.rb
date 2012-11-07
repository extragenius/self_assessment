Seeder = Dibber::Seeder

Seeder.seeds_path = "#{Rails.root}/db/seeds"

Seeder.monitor Questionnaire
Seeder.monitor Question
Seeder.monitor Answer
Seeder.monitor RuleSet

Seeder.objects_from('questions.yml').each do |holder, data|
  questionnaire = Questionnaire.find_or_create_by_title(data['title'])
  
  if data['questions']
    data['questions'].values.each do |question_data| 
      question = Question.find_or_create_by_title(question_data['question'])
      answer = question.answers.find_or_create_by_value('Yes')
      rule_set = RuleSet.find_or_initialize_by_title(question_data['title'])
      rule_set.url = question_data['url']
      rule_set.answers = [answer]
      rule_set.save
      questionnaire.questions << question
    end
  end
end

Seeder.monitor AdminUser
admin_email = 'admin@warwickshire.gov.uk'
password = 'password'
AdminUser.create!(
  :email => admin_email,
  :password => password,
  :password_confirmation => password
) unless AdminUser.exists?(:email => admin_email)

puts Seeder.report