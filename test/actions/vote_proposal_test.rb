require 'test_helper'

class VoteProposalTest < ActiveSupport::TestCase
  def some_email; "someone@some.tld"; end

  setup do
    @voter = Voter.new(email: some_email)
    @proposal = Proposal.new(title: not_blank, description: not_blank, budget: zero_or_positive_number)
  end

  test "vote shouldn't be registered for an unverified voter" do
    VoteProposal.call(@voter, @proposal)
    assert_equal 0, @proposal.voters.size
  end

  test "vote should be registered for a verified voter" do
    @voter.verify!
    VoteProposal.call(@voter, @proposal)
    assert_equal 1, @proposal.voters.size
  end

  test "vote shouldn't be registered more than once for the same voter" do
    @voter.verify!
    2.times { VoteProposal.call(@voter, @proposal) }
    assert_equal 1, @proposal.voters.size
  end
end