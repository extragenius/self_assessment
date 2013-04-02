require "#{Rails.root}/app/decorators/models/qwester/rule_set_decorator"

# map existing constants to Qwester versions

Answer = Qwester::Answer
AnswerStore = Qwester::AnswerStore
Question = Qwester::Question
Questionnaire = Qwester::Questionnaire
RuleSet = Qwester::RuleSet
Presentation = Qwester::Presentation

Qwester.active_admin_menu = 'Questionnaire items'

Qwester::Answer.weighting_alias = :cope_index