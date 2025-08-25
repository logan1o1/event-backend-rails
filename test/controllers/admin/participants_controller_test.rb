require "test_helper"

class Admin::ParticipantsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_participants_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_participants_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_participants_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_participants_destroy_url
    assert_response :success
  end
end
