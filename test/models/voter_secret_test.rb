require 'test_helper'

class VoterSecretTest < ActiveSupport::TestCase
  setup do
    @voter_secret = VoterSecret.new
  end

  test "should be valid" do
    assert @voter_secret.valid?
  end

  test "may include some data" do
    assert_not @voter_secret.data?
    @voter_secret.data = { 'some_key' => 'some_value', 'some_other_key' => 'some_other_value' }
    assert @voter_secret.data?
    assert @voter_secret.valid?
  end

  test "reports the list of secrets" do
    list_of_secrets = VoterSecret.list_of_secrets
    assert_equal list_of_secrets_from_fixture_data.sort, list_of_secrets.sort
  end

  def list_of_secrets_from_fixture_data
    ['some_secret', 'some_another_secret']
  end
end
