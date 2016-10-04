require 'test_helper'

class ClassifierTest < ActiveSupport::TestCase
  setup do
    @classifier = Classifier.new(name: not_blank, type: blank)
  end

  test "shouldn't be valid" do
    assert_not @classifier.valid?
  end
end
