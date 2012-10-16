# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Questionnaires: #{Questionnaire.count}"
puts "Questions: #{Question.count}"
puts "Answers: #{Answer.count}"
puts "RuleSets: #{RuleSet.count}"

questions = YAML::load( File.open( "#{Rails.root}/db/seeds/questions.yml" ) )

questions.values.each do |data|  
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

puts "Questionnaires: #{Questionnaire.count}"
puts "Questions: #{Question.count}"
puts "Answers: #{Answer.count}"
puts "RuleSets: #{RuleSet.count}"