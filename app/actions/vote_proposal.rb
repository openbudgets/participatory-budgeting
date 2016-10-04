class VoteProposal
  def self.call(voter, proposal)
    new(voter, proposal).call
  end

  def call
    return false unless @proposal && @voter && @voter.verified?
    return true if @proposal.voted_by?(@voter)
    @proposal.voters.push(@voter)
    @proposal.save
  end

  private

  def initialize(voter, proposal)
    @voter = voter
    @proposal = proposal
  end

end
