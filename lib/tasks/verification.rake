namespace :verification do
  desc "Email a reminder to the voters with pending verification status"
  task remind: :environment do
    voters = Voter.where(verified: false).where.not(verification_token: nil)
    puts "Sending reminder to #{voters.size} voters..."
    voters.each do |voter|
      VoterMailer.voter_reminder_email(voter).deliver
    end
    puts "Done!"
  end
end