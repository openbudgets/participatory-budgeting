require 'test_helper'

class RegisterVoterTest < ActiveSupport::TestCase
  def some_valid_email; "someone@some.tld"; end
  def some_invalid_email; "someone.some.tld"; end
  def some_valid_secret; voter_secrets(:some_voter_secret).data; end
  def some_invalid_secret; VoterSecret.new.data; end

  setup do
    ApplicationMailer.deliveries.clear
  end

  test "with invalid email voter shouldn't be registered" do
    voter = RegisterVoter.call(some_invalid_email, some_valid_secret)
    assert_not voter
  end

  test "with invalid secret voter shouldn't be registered" do
    voter = RegisterVoter.call(some_valid_email, some_invalid_secret)
    assert_not voter
  end

  test "with valid email and secret voter should be registered and verification token should be generated" do
    voter = RegisterVoter.call(some_valid_email, some_valid_secret)
    assert voter.verification_token
  end

  test "verification email should be sent when the voter is registered" do
    assert_difference('ApplicationMailer.deliveries.size', 1) do
      RegisterVoter.call(some_valid_email, some_valid_secret)
    end
  end

  test "with valid email voter should be registered if secrets aren't required" do
    remove_secrets!
    voter = RegisterVoter.call(some_valid_email)
    assert voter.verification_token
    restore_secrets!
  end

  def remove_secrets!
    @voter_secrets = VoterSecret.all.to_a
    VoterSecret.delete_all
  end

  def restore_secrets!
    @voter_secrets.each{ |voter_secret| VoterSecret.create(voter_secret.attributes) }
  end
end
