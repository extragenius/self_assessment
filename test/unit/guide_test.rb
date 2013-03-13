require 'test_helper'

class GuideTest < ActiveSupport::TestCase
  def setup
    @guide = Guide.find(1)
  end
  
  def test_name
    valid = %w{name this foo_bar mary_smith one_day_my_star_will_com a1}
    valid.each do |name|
      @guide.name = name
      assert(@guide.save, "Should be able to save guide with name of #{name}")
    end
  end
  
  def test_invalid_name
    invalid = ['Name', 'This', 'foo bar', 'Mary Smith', 'One day my star will come']
    invalid.each do |name|
      @guide.name = name
      assert(!@guide.save, "Should not be able to save guide with name of #{name}")
      assert(@guide.errors[:name], "Should be errors against name #{name}")
    end
  end
end
