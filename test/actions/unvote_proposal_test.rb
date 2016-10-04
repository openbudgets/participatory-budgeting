require 'test_helper'

class UnvoteProposalTest < ActiveSupport::TestCase
  def some_email; "someone@some.tld"; end

  setup do
    @voter = Voter.new(email: some_email)
    @proposal = Proposal.new(title: not_blank, description: not_blank, budget: zero_or_positive_number)
    @proposal.voters << @voter
  end

  test "unvote shouldn't be registered for an unverified voter" do
    UnvoteProposal.call(@voter, @proposal)
    assert_equal 1, @proposal.voters.size
  end

  test "unvote should be registered for a verified voter" do
    @voter.verify!
    UnvoteProposal.call(@voter, @proposal)
    assert_equal 0, @proposal.voters.size
  end

  test "vote shouldn't be registered more than once for the same voter" do
    @voter.verify!
    2.times { UnvoteProposal.call(@voter, @proposal) }
    assert_equal 0, @proposal.voters.size
  end
end