class VoterMailer < ApplicationMailer
  def voter_verification_email(voter)
    @voter = voter
    mail(to: @voter.email, subject: _('Voter verification token'))
  end

  def voter_reminder_email(voter)
    @voter = voter
    mail(to: @voter.email, subject: _('Voter verification reminder'))
  end

  def voter_hint_email(voter)
    @voter = voter
    mail(to: @voter.email, subject: _('Voter verification hint'))
  end
end
