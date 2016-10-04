# Preview all emails at http://localhost:3000/rails/mailers/voter_mailer
class VoterMailerPreview < ActionMailer::Preview
  def last_voter_verification_email
    voter = Voter.order(:updated_at).last
    VoterMailer.voter_verification_email(voter)
  end
end
