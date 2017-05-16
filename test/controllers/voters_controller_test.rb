require 'test_helper'

class VotersControllerTest < ActionDispatch::IntegrationTest
  def some_email; "someone@some.tld"; end
  def some_voter_secret; voter_secrets(:some_voter_secret).data; end

  setup do
    @voter = voters(:not_verified)
  end

  test "should get to voter registration" do
    get new_voter_path
    assert_response :success
  end

  test "should register a voter when secrets are required" do
    params = {
      voter: {
        email: some_email,
        secret_data: some_voter_secret
      }
    }
    post voters_path, params: params
    assert flash[:notice]
    assert_response :redirect
  end

  test "should verify a voter, ask for her name, sign her in and redirect" do
    @voter.generate_verification_token!
    token = @voter.verification_token
    get verify_voters_path(token: token)
    assert_response :success
    assert_select 'input[type][value]', type: 'submit', value: 'Verify'
    patch voter_path(@voter)
    assert_equal @voter.id, session[:voter]
    assert_response :redirect
  end

  test "should sign in a voter and redirect" do
    @voter.verified = true
    @voter.name = not_blank
    @voter.generate_verification_token!
    token = @voter.verification_token
    get verify_voters_path(token: token)
    assert flash[:success]
    assert_equal @voter.id, session[:voter]
    assert_response :redirect
  end

  test "should sign out a signed in voter" do
    sign_in(@voter)
    get signout_voters_path
    assert flash[:success]
    assert_not session[:voter]
    assert_response :redirect
  end

  test "shouldn't register a voter without secrets when secrets are required" do
    assert_not VoterSecret.list_of_secrets.empty?
    params = {
      voter: {
        email: some_email
      }
    }
    post voters_path, params: params
    assert flash[:error]
    assert_response :redirect
    assert_match new_voter_path, @response.redirect_url
  end

  test "should register a voter when secrets aren't required" do
    remove_secrets!
    assert VoterSecret.list_of_secrets.empty?
    params = {
      voter: {
        email: some_email
      }
    }
    post voters_path, params: params
    assert flash[:notice]
    assert_response :redirect
    restore_secrets!
  end

  test "should ask a voter her secrets when secrets are required" do
    assert_not VoterSecret.list_of_secrets.empty?
    get new_voter_path
    assert_select 'input[id^=voter_secret_data_]', VoterSecret.list_of_secrets.size
  end

  def remove_secrets!
    @voter_secrets = VoterSecret.all.to_a
    VoterSecret.delete_all
  end

  def restore_secrets!
    @voter_secrets.each{ |voter_secret| VoterSecret.create(voter_secret.attributes) }
  end
end
