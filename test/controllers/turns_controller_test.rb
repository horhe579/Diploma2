require "test_helper"

class TurnsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get turns_index_url
    assert_response :success
  end

  test "should get create" do
    get turns_create_url
    assert_response :success
  end

  test "should get update" do
    get turns_update_url
    assert_response :success
  end

  test "should get destroy" do
    get turns_destroy_url
    assert_response :success
  end
end
