Qwester::RuleSet.class_eval do
  belongs_to :warning, :class_name => 'Ominous::Warning'
end