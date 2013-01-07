module Report

  class Base
    attr_reader :title, :data, :name
   
    def initialize(name)
      raise "Chart not recognised: #{name}" unless self.class.private_instance_methods.include?(name.to_sym)
      @title = name.to_s.humanize
      @data = instance_eval(name.to_s)
      @name = name
    end
  end

end
