module Qwester

  ActiveAdmin.register RuleSet do
    
    index do
      column :title
      column :presentation
      column :warning
      column :rule
      column :answers do |rule_set|
        rule_set.answers.count
      end
      default_actions
    end
    
 
    form do |f|
      require "#{Rails.root}/app/decorators/models/qwester/rule_set_decorator" # Page fails to see qwester_rule_set.warning method on page refresh sometimes, unless this require is included in each declaration that rule_set.warning is needed!
      
      f.inputs "Details" do
        f.input :title
        if defined?(Ckeditor)
          f.input :description, :as => :ckeditor, :input_html => { :height => 100 }
        else
          f.input :description, :input_html => { :rows => 3}
        end
      end
      
      f.inputs "Output Link" do
        f.input :url
        f.input :link_text        
      end
      
      f.inputs "Change Presentation of Questionnaires" do
        f.input :presentation, :as => :select, :collection => Presentation.all.collect(&:name), :include_blank => 'No effect on presentation'
      end
      
      f.inputs "Logic" do
        f.input :warning,  :as => :select,      :collection => Ominous::Warning.all
        f.input :rule, :input_html => { :rows => 3}
      end
      
      f.buttons
      
      f.inputs("Questions") do 
        
        if qwester_rule_set.questions.empty?
          
          f.input(
            :answers, 
            :as => :check_boxes, 
            :member_label => lambda {|a| "a#{a.id}: #{a.value} to '#{a.question.title}'"},
            :input_html => { :size => 20, :multiple => true}
          ) 
                  
        else
          
          questions = qwester_rule_set.questions | Question.all
          questions.collect! do |question|
            style = 'border:#CCCCCC 1px solid;'
            html = [content_tag('td', question.title, :style => style)]
            answers = question.answers.collect do |answer|
              answer_style = style
              answer_style += 'background-color:#005C1F;color:white;font-weight:bold;' if qwester_rule_set.answers.include?(answer)
              content_tag('td', "a#{answer.id} #{answer.value}".html_safe, :style => answer_style).html_safe
            end
            html << answers.join(" ").html_safe
            content_tag('tr', html.join(" ").html_safe)
          end
          table_class = ["selection"]
          table_class << 'associated_questions' if qwester_rule_set.id.present?
          content_tag 'li', content_tag('table', questions.join("\n").html_safe, :class => table_class.join(' '))
        
        end
        
      end
      
    end
    
    show do
      require "#{Rails.root}/app/decorators/models/qwester/rule_set_decorator" # Page fails to see qwester_rule_set.warning method on page refresh sometimes, unless this require is included in each declaration that rule_set.warning is needed!
      div do
        para sanitize(qwester_rule_set.description) 
      end if qwester_rule_set.description.present?
      
      div do
        h3 'Target url'
        para link_to qwester_rule_set.url
        para qwester_rule_set.link_text? ? qwester_rule_set.link_text : 'No link text specified'
      end
      
      div do
        h3 'Presentation'
        if qwester_rule_set.presentation?
          para "The presentations of questionnaires should change to: #{qwester_rule_set.presentation}"
        else
          para "The presentations of questionnaires should be unaffected by this rule"
        end
      end
      
      if qwester_rule_set.warning
        div do
          h3 'Associated Warning'
          para content_tag('strong', qwester_rule_set.warning.name)
          para 'This warning will be triggered if this rule is matched'
        end
      end
      
      div do
        h3 'The rule'
        para qwester_rule_set.rule
      end
      
      if qwester_rule_set.matching_answer_sets.present?
        div do
          h3 'Sample matching answer sets'
          if qwester_rule_set.matching_answer_sets.length
            para "There are at least #{qwester_rule_set.matching_answer_sets.length} combinations of answers that would pass this test."
          end
          para 'The following combinations of answers would pass'
          qwester_rule_set.matching_answer_sets.each do |answer_set|
            ul :style => 'border:#CCCCCC 1px solid;padding:5px;list-style:none;' do
              answer_set.each do |answer_id|
                next unless Answer.exists?(answer_id)
                answer = Answer.find(answer_id)
                question_summary = [answer.value, answer.question.title].join(' : ')
                li "(a#{answer_id}) #{question_summary}"
              end
            end
          end
        end
      else
        div do
          h3 'Matching answer sets'
          para 'Answers will pass unless they contain a blocking answer set'
        end
      end
      
      if qwester_rule_set.blocking_answer_sets.present?
        div do
          h3 'Sample blocking answer sets'
          para 'The following combinations of answers would not pass'
          qwester_rule_set.blocking_answer_sets.each do |answer_set|
             ul :style => 'border:#CCCCCC 1px solid;padding:5px;list-style:none;' do
              answer_set.each do |answer_id|
                next unless Answer.exists?(answer_id)
                answer = Answer.find(answer_id)
                question_summary = [answer.value, answer.question.title].join(' : ')
                li "(a#{answer_id}) #{question_summary}"
              end
            end
          end
        end
      else
        div do
          h3 'Blocking answer sets'
          para 'Answers will only pass if they contain a matching answer set'
        end
      end
      
    end  

  end if defined?(ActiveAdmin)

end