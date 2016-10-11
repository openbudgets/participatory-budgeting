require 'test_helper'

class Voting::ProposalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proposal = proposals(:park)
    @voter = voters(:verified)
  end

  test "should get proposals to vote" do
    get voting_proposals_path
    assert_response :success
  end

  test "should get proposal detail" do
    get voting_proposal_path(@proposal)
    assert_response :success
  end

  test "should register a vote if the user is signed in" do
    sign_in(@voter)
    patch voting_proposal_path(@proposal), params: {id: @voter.id}
    assert_response :success
  end

  test "shouldn't register a vote if the user is not signed in" do
    patch voting_proposal_path(@proposal), params: {id: @voter.id}
    assert_response :unprocessable_entity
  end

  test "shouldn't get vote summary data if the user is not signed in" do
    get summarize_voting_proposals_path
    assert_response :redirect
  end

  test "should get vote summary data if the user is signed in" do
    sign_in(@voter)
    get summarize_voting_proposals_path
    assert_response :success
  end

  test "should filter the proposal list if some criteria is provided" do
    get voting_proposals_path, params: { class: districts(:downtown).id, budget_min: '10000', budget_max: '25000'}
    assert_response :success
    assert_select '.proposal-title', 2
  end
end
