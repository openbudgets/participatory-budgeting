require 'test_helper'

class VoterMailerTest < ActionMailer::TestCase
  def some_email; "someone@some.tld"; end

  setup do
    @voter = Voter.new(email: some_email)
  end

  test "sends verification request" do
    email = VoterMailer.voter_verification_email(@voter)
    assert_emails 1 do
      email.deliver_now
    end
  end
end
