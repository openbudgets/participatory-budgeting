require 'test_helper'

class VoterTest < ActiveSupport::TestCase
  def some_valid_email; "someone@some.tld"; end
  def some_invalid_email; "someone.some.tld"; end
  def some_proposals; [proposals(:trees), proposals(:park)]; end

  setup do
    @voter = Voter.new(email: some_valid_email)
  end

  test "should be valid" do
    assert @voter.valid?
  end

  test "shouldn't be verified" do
    assert_not @voter.verified?
  end

  test "shouldn't have chosen any proposals" do
    assert @voter.proposals.blank?
  end

  test "email shouldn't be blank" do
    @voter.email = blank
    assert_not @voter.valid?
  end

  test "email should be valid" do
    @voter.email = some_invalid_email
    assert_not @voter.valid?
  end

  test "can generate a verification token" do
    token = @voter.generate_verification_token!
    assert token
  end

  test "can be verified" do
    @voter.verify!
    assert @voter.verified?
  end

  test "may choose some proposals" do
    @voter.proposals = some_proposals
    @voter.save!
    assert_equal 2, @voter.proposals.size
  end

  test "may have a name" do
    @voter.name = not_blank
    assert @voter.valid?
  end
end
