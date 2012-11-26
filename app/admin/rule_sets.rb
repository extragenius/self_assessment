ActiveAdmin.register RuleSet do

  index do
    column :title
    column :answers do |rule_set|
      rule_set.answers.count
    end
    column :rule
    default_actions
  end

  form :partial => 'rule_sets/form'

  show do
    div do
      para rule_set.description
    end if rule_set.description.present?

    div do
      h3 'Target url'
      para link_to rule_set.url
    end

    div do
      h3 'Matching answers'
      ul do
        rule_set.answers.each do |answer|
          li "<strong>#{answer.value}</strong> <em>to :-</em> #{answer.question.title}".html_safe

        end
      end
    end
    
    div do
      h3 'Custom rule'
      para rule_set.rule
    end
  end

  controller do
    before_filter :new_rule_set, :only => [:create]
    before_filter :get_rule_set, :only => [:update]

    def create
      if update_rule_set
        redirect_to :action => :show, :id => @rule_set.id
      else
        render :new
      end
    end

    def update
      create
    end

    private
    def new_rule_set
      @rule_set = RuleSet.new
    end

    def get_rule_set
      @rule_set = RuleSet.find(params[:id])
    end

    def update_rule_set
      @rule_set.attributes = params[:rule_set]
      @rule_set.answers = answers_in_params if answers_in_params
      @rule_set.save
    end

    def answers_in_params
      @answers_in_params ||= extract_answers_from_params
    end

    def answers_in_params?
      params[:answers] and params[:answers][:question_id]
    end

    def extract_answers_from_params
      if answers_in_params?
        questions = extract_questions_from_params
        questions.collect do |question|
          value = params[:answers][:question_id][question.id.to_s.to_sym]
          attributes = {
            :question_id => question.id,
            :value => value
          }
          Answer.find_first_or_create(attributes)
        end
      end
    end
  end
  
end
