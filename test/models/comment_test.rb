require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def some_valid_email; "someone@some.tld"; end

  setup do
    @voter = Voter.new(email: some_valid_email)
    @proposal = Proposal.new(title: not_blank, description: not_blank, budget: zero_or_positive_number)
    @comment = Comment.new(text: not_blank, voter: @voter, proposal: @proposal)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "text shouldn't be blank" do
    @comment.text = blank
    assert_not @comment.valid?
  end

  test "shouldn't be anonymous" do
    @comment.voter = nil
    assert_not @comment.valid?
  end

  test "should be about a proposal" do
    @comment.proposal = nil
    assert_not @comment.valid?
  end

  test "may have some responses" do
    response = Comment.new(text: not_blank, voter: @voter, proposal: @proposal)
    @comment.responses << response
    assert @comment.valid?
    assert_not @comment.responses.empty?
  end
end
