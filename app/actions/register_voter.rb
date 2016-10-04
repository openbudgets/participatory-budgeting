class RegisterVoter
  def self.call(email)
    new(email).call
  end

  def call
    return nil unless @voter.persisted?
    @voter.generate_verification_token!
    VoterMailer.voter_verification_email(@voter).deliver
    @voter
  end

  private

  def initialize(email)
    @voter = Voter.find_or_create_by(email: email)
  end
end