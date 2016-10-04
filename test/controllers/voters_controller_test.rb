require 'test_helper'

class VotersControllerTest < ActionDispatch::IntegrationTest
  def some_email; "someone@some.tld"; end

  setup do
    @voter = voters(:not_verified)
  end

  test "should get to voter registration" do
    get new_voter_path
    assert_response :success
  end

  test "should register the voter and redirect" do
    params = {
      voter: {
        email: some_email
      }
    }
    post voters_path, params: params
    assert_response :redirect
  end

  test "should verify the voter, ask for her name, sign her in and redirect" do
    @voter.generate_verification_token!
    token = @voter.verification_token
    get verify_voters_path(token: token)
    assert_response :success
    assert_select 'input[type][value]', type: 'submit', value: 'Verify'
    patch voter_path(@voter)
    assert_equal @voter.id, session[:voter]
    assert_response :redirect
  end

  test "should sign in the voter and redirect" do
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
end
