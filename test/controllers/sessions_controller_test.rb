require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = users(:customer) }

  test "new shows the sign-in form" do
    get new_session_path

    assert_response :success
    assert_select "h1", "Sign in"
    assert_select "input[type=email][name=email_address]"
    assert_select "input[type=password][name=password]"
    assert_select ".alert-error", count: 0
    assert_select ".topbar", count: 0
  end

  test "new redirects a signed-in user to the dashboard" do
    sign_in_as @user

    get new_session_path

    assert_redirected_to root_path
  end

  test "create with valid credentials signs in and redirects to the dashboard" do
    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to root_path
    assert cookies[:session_id]
  end

  test "create with an upper-case email still signs in" do
    post session_path, params: { email_address: " CUSTOMER@Example.com ", password: "password" }

    assert_redirected_to root_path
  end

  test "create with a wrong password shows an error and stays signed out" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }

    assert_response :unprocessable_entity
    assert_select ".alert-error", "Invalid email or password"
    assert_select "input[name=email_address][value=?]", @user.email_address
    assert_nil cookies[:session_id]
  end

  test "create with an unknown email shows the same error" do
    post session_path, params: { email_address: "nobody@example.com", password: "password" }

    assert_response :unprocessable_entity
    assert_select ".alert-error", "Invalid email or password"
    assert_nil cookies[:session_id]
  end

  test "create returns to the page the visitor first asked for" do
    get dashboard_path
    post session_path, params: { email_address: @user.email_address, password: "password" }

    assert_redirected_to dashboard_url
  end

  test "destroy ends the session and protected pages redirect again" do
    sign_in_as @user

    assert_difference -> { @user.sessions.count }, -1 do
      delete session_path
    end

    assert_redirected_to new_session_path
    assert_empty cookies[:session_id]

    get root_path
    assert_redirected_to new_session_path
  end
end
