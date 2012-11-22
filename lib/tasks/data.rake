namespace :data do

  # Usage: rake data:reset_positions RAILS_ENV=production
  desc "Goes through each of the acts_as_list objects and resets the positions based on order they were added to the database"
  task :reset_positions => :environment do

    ActiveRecord::Base.connection.execute "START TRANSACTION;"

    Questionnaire.all.each do |questionnaire|
      first_id = questionnaire.questionnaires_questions.minimum(:id)
      if first_id   # nil if questionnaire has no questions
        sql = "UPDATE questionnaires_questions SET position = (1 + id - #{first_id}) WHERE questionnaire_id = #{questionnaire.id};"
        ActiveRecord::Base.connection.execute sql
      end
    end

    ActiveRecord::Base.connection.execute "COMMIT;"

    puts "Positions reset"
  end

  desc "Removes duplicates from join tables"
  task :remove_duplicate_joins => :environment do
    sql_commands = <<EOF
START TRANSACTION;
CREATE TABLE questionnaires_questions_temp LIKE questionnaires_questions;
INSERT INTO questionnaires_questions_temp SELECT DISTINCT * FROM questionnaires_questions;
DROP TABLE questionnaires_questions;
RENAME TABLE questionnaires_questions_temp TO questionnaires_questions;
COMMIT;
EOF
    sql_commands.each_line do |sql|
      ActiveRecord::Base.connection.execute sql
    end
  end

  desc "Makes sure all questions have at least the default answers"
  task :populate_answers => :environment do
    Question.all.each do |question|
      next if question.answers.count > 1
      Answer.default_values.each do |value|
        question.answers.find_or_create_by_value(value)
      end
    end
  end

  desc "Testing environment"
  task :hello => :environment do
    puts "Hello World"
    puts "The environment is #{Rails.env}"
  end


end