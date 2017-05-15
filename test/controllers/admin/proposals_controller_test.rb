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

  test "should show proposal" do
    sign_in(@voter)
    get admin_proposal_url(@proposal)
    assert_response :success
  end

  test "should get edit" do
    sign_in(@voter)
    get edit_admin_proposal_url(@proposal)
    assert_response :success
  end

  test "should update proposal" do
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

  test "should complete proposal" do
    sign_in(@voter)
    patch admin_proposal_url(@proposal), params: { proposal: { completed: '1' } }
    assert_redirected_to admin_proposals_url
    follow_redirect!
    assert_response :success
    assert_select "#proposal-#{@proposal.id} .completed", 1
  end

  test "should upload image" do
    sign_in(@voter)
    patch admin_proposal_url(@proposal), params: { proposal: { image: fixture_file_upload('files/some_image.jpg', 'image/jpg') } }
    assert_redirected_to admin_proposals_url
    follow_redirect!
    assert_response :success
    assert_select '.proposal-image'
  end

  test "should remove an attached image" do
    @proposal.update(image: File.open("test/fixtures/files/some_image.jpg"))
    sign_in(@voter)
    patch admin_proposal_url(@proposal), params: { proposal: { image: '' }, delete_image: 'whatever' }
    assert_redirected_to admin_proposals_url
    follow_redirect!
    assert_response :success
    assert_select '.proposal-image', 0
  end
end
