require "test_helper"

class SignInTest < ActionDispatch::IntegrationTest
  test "sign-in page shows the form" do
    get new_session_path

    assert_response :success
    assert_select "h1", "Sign in"
    assert_select "input[type=email][name=email_address]"
    assert_select "input[type=password][name=password]"
    assert_select ".alert-error", count: 0
  end

  test "valid email and password signs in and lands on the dashboard" do
    post session_path, params: { email_address: "customer@example.com", password: "password" }

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "invalid password shows an error and stays signed out" do
    post session_path, params: { email_address: "customer@example.com", password: "wrong" }

    assert_response :unprocessable_entity
    assert_select ".alert-error", "Invalid email or password"
    assert_select "input[name=email_address][value=?]", "customer@example.com"

    get root_path
    assert_redirected_to new_session_path
  end

  test "unknown email shows the same error" do
    post session_path, params: { email_address: "nobody@example.com", password: "password" }

    assert_response :unprocessable_entity
    assert_select ".alert-error", "Invalid email or password"
  end

  test "signed-out visitor is sent to sign-in and back after signing in" do
    get root_path
    assert_redirected_to new_session_path

    post session_path, params: { email_address: "agent@example.com", password: "password" }
    assert_redirected_to root_url
  end

  test "signed-in user who opens sign-in goes to the dashboard" do
    sign_in_as users(:customer)

    get new_session_path

    assert_redirected_to root_path
  end

  test "no password-reset routes exist" do
    assert_not Rails.application.routes.named_routes.key?(:passwords)
    assert_raises(ActionController::RoutingError) do
      Rails.application.routes.recognize_path("/passwords/new")
    end
  end
end
