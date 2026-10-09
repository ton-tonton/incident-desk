require "test_helper"

class AuthenticationRoutesTest < ActionDispatch::IntegrationTest
  test "no password-reset routes exist" do
    paths = Rails.application.routes.routes.map { |route| route.path.spec.to_s }

    assert_empty paths.grep(/password/)
    assert_not defined?(PasswordsController)
  end
end
