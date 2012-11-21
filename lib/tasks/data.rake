namespace :data do

  # Usage: rake data:reset_positions RAILS_ENV=production
  desc "Goes through each of the acts_as_list objects and resets the postions"
  task :reset_positions => :environment do
    QuestionnairesQuestion.all.reverse.each(&:move_to_top)
    puts "Positions reset"
  end

  desc "Testing environment"
  task :hello => :environment do
    puts "Hello World"
    puts "The environment is #{Rails.env}"
  end


end