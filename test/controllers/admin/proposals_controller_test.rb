require 'test_helper'

class Admin::ProposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proposal = proposals(:trees)
    @voter = voters(:admin)
  end

  test "should get index" do
    sign_in(@voter)
    get admin_proposals_url
    assert_response :success
  end

  test "should get new" do
    sign_in(@voter)
    get new_admin_proposal_url
    assert_response :success
  end

  test "should create proposal" do
    sign_in(@voter)
    assert_difference('Proposal.count') do
      post admin_proposals_url, params: { proposal: { title: not_blank, description: not_blank, budget: zero_or_positive_number } }
    end
    assert_redirected_to admin_proposals_url
  end

  test "should show_proposal" do
    sign_in(@voter)
    get admin_proposal_url(@proposal)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@voter)
    get edit_admin_proposal_url(@proposal)
    assert_response :success
  end

  test "should update_proposal" do
    sign_in(@voter)
    patch admin_proposal_url(@proposal), params: { proposal: { title: not_blank, description: not_blank, budget: zero_or_positive_number } }
    assert_redirected_to admin_proposals_url
  end

  test "should destroy proposal" do
    sign_in(@voter)
    assert_difference('Proposal.count', -1) do
      delete admin_proposal_url(@proposal)
    end
    assert_redirected_to admin_proposals_url
  end
end
