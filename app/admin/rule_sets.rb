ActiveAdmin.register RuleSet do

  index do
    column :title
    column :answers do |rule_set|
      rule_set.answers.count
    end
    column :rule
    default_actions
  end

  form :partial => 'admin/rule_sets/form'

  show do
    render :template => 'admin/rule_sets/show'
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
