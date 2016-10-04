require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  setup do
    @district = District.new(name: not_blank)
  end

  test "should be valid" do
    assert @district.valid?
  end

  test "name shouldn't be blank" do
    @district.name = blank
    assert_not @district.valid?
  end
end
