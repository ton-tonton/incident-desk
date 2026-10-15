require "test_helper"

class TopBarTest < ActionDispatch::IntegrationTest
  test "customer sees their email, role and a log out button" do
    sign_in_as users(:customer)

    get root_path

    assert_select "header.topbar" do
      assert_select ".brand", "Incident Desk"
      assert_select ".user", /customer@example\.com · Customer/
      assert_select "form[action=?] button", session_path, "Log out"
    end
    assert_select "h1", "My tickets"
  end

  test "agent sees their role and the agent dashboard" do
    sign_in_as users(:agent)

    get root_path

    assert_select ".user", /agent@example\.com · Agent/
    assert_select "h1", "All tickets"
  end

  test "sign-in page has no top bar" do
    get new_session_path

    assert_select "header.topbar", count: 0
  end

  test "log out ends the session and protected pages redirect again" do
    post session_path, params: { email_address: "customer@example.com", password: "password" }

    assert_difference -> { Session.count }, -1 do
      delete session_path
    end
    assert_redirected_to new_session_path

    get root_path
    assert_redirected_to new_session_path
  end
end
