class Setting < ActiveRecord::Base

  attr_accessible :name, :value, :value_type, :description

  VALUE_TYPES = {
    'text' => String,
    'number' => Float,
    'decimal' => BigDecimal
  }

  validates :value_type, :presence => true, :inclusion => {:in => VALUE_TYPES.keys}
  validates :value, :presence => true
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
    end if value_type.present?

  end

end
