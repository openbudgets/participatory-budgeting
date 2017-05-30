require 'test_helper'

class VerificationFlowTest < ActionDispatch::IntegrationTest
  def some_valid_email; "someone@some.tld"; end
  def some_valid_voter_secret; voter_secrets(:some_voter_secret).data; end

  test "should remind the voter to finish the verification process" do
    visit_home!
    visit_proposals!
    visit_registration!(redirect: voting_proposals_path)
    post_registration!(expected_redirect: voting_proposals_path)
    assert_match /verification pending/i, _(flash[:notice])

    visit_home!
    assert_match /verification pending/i, _(flash[:notice])
  end

  test "should ask the voter for her name" do
    visit_home!
    visit_registration!(redirect: root_path)
    post_registration!(expected_redirect: root_path)
    find_voter

    get verify_voters_path(token: @voter.verification_token)
    assert_response :success
    assert_not session[:voter]
    assert_select 'input[type][value]', type: 'submit', value: _('Verify')
  end

  test "shouldn't ask the voter for her name if it is already fulfilled" do
    visit_home!
    visit_registration!(redirect: root_path)
    post_registration!(expected_redirect: root_path)
    find_voter

    get verify_voters_path(token: @voter.verification_token)
    assert_response :success
    assert_not session[:voter]
    assert_select 'input[type][value]', type: 'submit', value: _('Verify')

    patch voter_path(@voter), params: { voter: { name: not_blank } }
    @voter.reload
    assert_response :redirect
    assert_match root_path, @response.redirect_url
    follow_redirect!
    assert_response :success
    assert_match /successfully verified/i, _(flash[:success])
    assert_equal @voter.id, session[:voter]
    assert_select 'a[href]', href: '/voters/signout', text: _('Sign out')

    get signout_voters_path
    assert_response :redirect
    assert_match root_path, @response.redirect_url
    follow_redirect!
    assert_response :success
    assert_match /successfully signed out/i, _(flash[:success])
    assert_not session[:voter]
    assert_select 'a[href]', href: '/voters/new?redirect=%2F', text: _('Sign in / Register')

    visit_proposals!
    visit_registration!(redirect: voting_proposals_path)
    post_registration!(expected_redirect: voting_proposals_path)
    @voter.reload
    assert_match /verification pending/i, _(flash[:notice])
    assert_equal voting_proposals_path, session[:redirect]

    get verify_voters_path(token: @voter.verification_token)
    assert_response :redirect
    assert_match voting_proposals_path, @response.redirect_url
    follow_redirect!
    assert_response :success
    assert_match /successfully verified/i, _(flash[:success])
    assert_equal @voter.id, session[:voter]
    assert_select 'a[href]', href: '/voters/signout', text: _('Sign out')
  end

  private

  def visit_home!
    get root_path
    assert_response :success
    assert_select 'a[href]', href: '/voters/new?redirect=%2F', text: _('Sign in / Register')
  end

  def visit_proposals!
    get voting_proposals_path
    assert_response :success
    assert_select 'a[href]', href: '/voters/new?redirect=%2Fproposals', text: _('Sign in / Register')
  end

  def visit_registration!(redirect:)
    get new_voter_path(redirect: redirect)
    assert_response :success
    assert_select 'input[type][value]', type: 'submit', value: _('Register')
    assert_equal redirect, session[:redirect]
  end

  def post_registration!(expected_redirect:)
    post voters_path, params: { voter: {  email: some_valid_email, secret_data: some_valid_voter_secret } }
    assert_response :redirect
    assert_match expected_redirect, @response.redirect_url
    follow_redirect!
    assert_response :success
    assert flash[:notice]
    assert_select 'a[href]', href: "/voters/new?redirect=#{expected_redirect.html_safe}", text: _('Sign in / Register')
    assert session[:verification_pending]
    assert session[:redirect]
  end

  def find_voter
    @voter ||= Voter.find_by(email: some_valid_email)
  end
end
