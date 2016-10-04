require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup do
    @tag = Tag.new(name: not_blank)
  end

  test "should be valid" do
    assert @tag.valid?
  end

  test "name shouldn't be blank" do
    @tag.name = blank
    assert_not @tag.valid?
  end
end