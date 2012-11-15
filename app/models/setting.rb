class Setting < ActiveRecord::Base

  VALUE_TYPES = {
    'text' => String,
    'number' => Float,
    'decimal' => BigDecimal
  }

  validates :value_type, :presence => true, :inclusion => {:in => VALUE_TYPES.keys}
  validates :value_type, :presence => true
  validates :name, :uniqueness => true, :presence => true

  def self.value_types
    VALUE_TYPES.keys
  end

  def value
    case value_type
      when 'number'
        super.to_f
      else
        VALUE_TYPES[value_type].new(super)
    end

  end

end
