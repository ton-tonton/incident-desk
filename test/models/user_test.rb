require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "stores the password hashed, never in plain text" do
    user = User.create!(email_address: "new@example.com", password: "s3cret-pass", role: "customer")

    assert_not_includes user.reload.password_digest, "s3cret-pass"
    assert user.authenticate("s3cret-pass")
    assert_not User.column_names.include?("password")
  end

  test "role is customer or agent" do
    assert_equal "customer", users(:customer).role
    assert_equal "agent", users(:agent).role
  end

  test "requires a role" do
    user = User.new(email_address: "new@example.com", password: "s3cret-pass")

    assert_not user.valid?
    assert_includes user.errors[:role], "can't be blank"
  end

  test "rejects a role other than customer or agent" do
    user = User.new(email_address: "new@example.com", password: "s3cret-pass", role: "admin")

    assert_not user.valid?
    assert_includes user.errors[:role], "is not included in the list"
  end

  test "changing the role replaces the old one" do
    user = users(:customer)

    user.update!(role: "agent")

    assert_equal [ "agent" ], user.reload.roles.pluck(:name)
  end
end
