require "test_helper"

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get households_show_url
    assert_response :success
  end

  test "should get create" do
    get households_create_url
    assert_response :success
  end

  test "should get delete" do
    get households_delete_url
    assert_response :success
  end

  test "should get update" do
    get households_update_url
    assert_response :success
  end
end
