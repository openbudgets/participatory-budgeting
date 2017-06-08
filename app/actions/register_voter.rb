class RegisterVoter
  def self.call(email, secret=nil)
    secret ||= {}
    new(email, secret).call
  end

  def call
    return nil unless (@voter.persisted? && valid_secret?)

    @voter.generate_verification_token!
    VoterMailer.voter_verification_email(@voter).deliver
    @voter
  end

  private

  def initialize(email, secret)
    secret[:birth_date] = DateParser.parse(secret[:birth_date]).to_s if secret[:birth_date]
    secret[:document]   = DocumentNumberParser.parse(secret[:document]) if secret[:document]

    @voter = Voter.find_or_create_by(email: email)
    @secret = VoterSecret.find_by("data = :data", data: hstore(secret))
  end

  def hstore(hash)
    hash.to_s[1...-1]
  end

  def valid_secret?
    return true if VoterSecret.list_of_secrets.empty?

    !@secret.nil?
  end
end
