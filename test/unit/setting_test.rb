require_relative '../test_helper'

class SettingTest < ActiveSupport::TestCase

  def setup
    @number = Setting.find(1)
    @text = Setting.find(2)
    @decimal = Setting.find(3)
  end

  def test_number_value
    assert_kind_of(Float, @number.value)
  end

  def test_text_value
    assert_kind_of(String, @text.value)
  end

  def test_decimal_value
    assert_kind_of(BigDecimal, @decimal.value)
  end

  def test_valid_types
    Setting::VALUE_TYPES.each do |valid_type|
      @number.value_type = valid_type
      assert(@number.valid?, "@number should be valid when value_type = #{valid_type}")
    end
  end

  def test_invalid_type
    @number.value_type = 'invalid'
    assert(@number.invalid?, "@number should be invalid")
  end

  def test_for
    [@number, @text, @decimal].each do |setting|
      assert_equal(setting.value, Setting.for(setting.name.to_sym))
    end
  end

  def test_for_when_no_matching_setting
    assert_nil(Setting.for(:nothing), "Should return nil when setting doesn't exist")
  end
end
