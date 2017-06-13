namespace :verification do
  desc "Email a reminder to the voters with pending verification status"
  task remind: :environment do
    puts "Sending reminder to #{voters_to_remind.size} voters..."
    send_email_to(voters_to_remind) do |voter|
      VoterMailer.voter_reminder_email(voter).deliver
    end
    puts "Done!"
  end

  desc "Email a hint to the voters that provided wrong secrets"
  task hint: :environment do
    puts "Sending hint to #{voters_to_hint.size} voters..."
    send_email_to(voters_to_hint) do |voter|
      VoterMailer.voter_hint_email(voter).deliver
    end
    puts "Done!"
  end

  def voters_to_remind
    unverified_voters_batch.where.not(verification_token: nil)
  end

  def voters_to_hint
    unverified_voters_batch.where(verification_token: nil)
  end

  def unverified_voters_batch
    lapse = ENV['REMINDER_LAPSE'] || 3
    Voter.where(verified: false).where('updated_at < :lapse', lapse: lapse.days.ago)
  end

  def send_email_to(voters=[], &block)
    I18n.locale = (ENV['DEFAULT_LOCALE'] || I18n.default_locale)
    voters.each do |voter|
      begin
        yield voter
        voter.touch
      rescue Net::SMTPFatalError
        puts "ERROR: couldn't deliver message to #{voter.email}"
        next
      end
    end
  end
end