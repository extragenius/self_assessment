class Setting < ActiveRecord::Base

  attr_accessible :name, :value, :value_type, :description

  VALUE_TYPES = %w{text number decimal}


  validates :value_type, :presence => true, :inclusion => {:in => VALUE_TYPES}
  validates :value, :presence => true
  validates :name, :uniqueness => true, :presence => true

  def self.value_types
    VALUE_TYPES
  end

  def self.for(name)
    setting = find_by_name(name)
    setting.value if setting
  end

  def value
    if value_type.present?
      case value_type.to_s
        when 'number'
          super.to_f
        when 'decimal'
          BigDecimal.new(super)
        else
          super
      end
    end
  end

end
