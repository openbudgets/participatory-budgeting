require 'test_helper'

class ProposalImageUploaderTest < ActiveSupport::TestCase
  setup do
    @proposal = proposals(:lane)
  end

  test "should allow image uploads" do
    assert @proposal.update(image: File.open("test/fixtures/files/some_image.jpg"))
  end

  test "shouldn't allow non image uploads" do
    assert_not @proposal.update(image: File.open("test/fixtures/files/some_document.pdf"))
  end

  test "shouldn't allow too big uploads" do
    assert_not @proposal.update(image: File.open("test/fixtures/files/some_8mb_image.png"))
  end
end