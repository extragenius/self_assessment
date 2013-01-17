require "#{Qwester::Engine.config.root}/app/models/qwester/rule_set"

module Qwester
  class RuleSet < ActiveRecord::Base
    belongs_to :warning, :class_name => 'Ominous::Warning'
  end
end
