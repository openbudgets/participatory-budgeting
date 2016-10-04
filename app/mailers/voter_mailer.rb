class VoterMailer < ApplicationMailer
  def voter_verification_email(voter)
    @voter = voter
    mail(to: @voter.email, subject: "Voter verification token")
  end
end
