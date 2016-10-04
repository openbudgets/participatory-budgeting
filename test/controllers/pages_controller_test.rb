require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get terms of service" do
    get terms_of_service_path
    assert_response :success
  end

  test "should get privacy policy" do
    get privacy_policy_path
    assert_response :success
  end
end