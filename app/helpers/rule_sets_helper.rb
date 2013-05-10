module RuleSetsHelper

  def question_summary(answer) 
    value = content_tag(:strong, answer.value)
    separator = content_tag(:em, 'to :-')
    sanitize [value, separator, answer.question.title].join(" ")
  end
  
  def question_summary_for(answer_id)
    question_summaries[answer_id] ||= add_answer_to_question_summaries(answer_id)
  end
  
  def question_summaries
    @question_summaries ||= Hash.new
  end
  
  def add_answer_to_question_summaries(answer_id)
    if Answer.exists?(answer_id)
      answer = Answer.find(answer_id)
      question_summaries[answer_id] = question_summary(answer)
    end
  end
  
  def link_to_rule_set_url(rule_set)
    text = rule_set.link_text? ? rule_set.link_text : t('rule_set.default_url_text')
    link_to(text, rule_set.url, :target => '_blank')
  end
  
  def display_rule_set(rule_set, name = nil)
    answers = @answers = rule_set.answers & @qwester_answer_store.answers
      content_tag(
        'div',
        render(:partial => 'rule_sets/rule_set', :locals => {:rule_set => rule_set, :answers => answers}),
        :id => name
      )
  end
  
end
