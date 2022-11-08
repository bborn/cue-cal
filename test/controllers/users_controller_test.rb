require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get invite" do
    get users_invite_url
    assert_response :success
  end
end
