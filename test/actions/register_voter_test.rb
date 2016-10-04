require 'test_helper'

class RegisterVoterTest < ActiveSupport::TestCase
  def some_valid_email; "someone@some.tld"; end
  def some_invalid_email; "someone.some.tld"; end

  setup do
    ApplicationMailer.deliveries.clear
  end

  test "with invalid email voter shouldn't be registered" do
    voter = RegisterVoter.call(some_invalid_email)
    assert_not voter
  end

  test "with valid email voter should be registered and verification token should be generated" do
    voter = RegisterVoter.call(some_valid_email)
    assert voter.verification_token
  end

  test "verification email should be sent when the voter is registered" do
    assert_difference('ApplicationMailer.deliveries.size', 1) do
      RegisterVoter.call(some_valid_email)
    end
  end
end
