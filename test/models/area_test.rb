require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  setup do
    @area = Area.new(name: not_blank)
  end

  test "should be valid" do
    assert @area.valid?
  end

  test "name shouldn't be blank" do
    @area.name = blank
    assert_not @area.valid?
  end
end
