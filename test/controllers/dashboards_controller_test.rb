require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "signed-out visitor is redirected to sign-in" do
    get root_path

    assert_redirected_to new_session_path
  end

  test "customer sees My tickets and the top bar" do
    sign_in_as users(:customer)

    get root_path

    assert_response :success
    assert_select "h1", "My tickets"
    assert_select ".topbar .brand", "Incident Desk"
    assert_select ".topbar .user span", "customer@example.com · Customer"
    assert_select ".topbar form[action=?] button", session_path, text: "Log out"
  end

  test "agent sees All tickets and the top bar" do
    sign_in_as users(:agent)

    get root_path

    assert_response :success
    assert_select "h1", "All tickets"
    assert_select ".topbar .user span", "agent@example.com · Agent"
  end
end
