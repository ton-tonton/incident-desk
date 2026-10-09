require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "stores the password hashed" do
    user = User.create!(email_address: "new@example.com", password: "s3cret-pass")

    assert_not_equal "s3cret-pass", user.password_digest
    assert user.authenticate("s3cret-pass")
  end

  test "requires a valid, unique email address" do
    assert_not User.new(email_address: "not-an-email", password: "x").valid?
    assert_not User.new(email_address: users(:customer).email_address, password: "x").valid?
  end

  test "fixtures have their roles" do
    assert users(:customer).customer?
    assert users(:agent).agent?
    assert_not users(:agent).customer?
  end

  test "create_with_role! creates a user with the given role" do
    user = User.create_with_role!(email_address: "new@example.com", password: "s3cret-pass", role: "agent")

    assert_equal "agent", user.role
  end

  test "create_with_role! rejects an unknown role and saves nothing" do
    assert_no_difference -> { User.count } do
      assert_raises(ArgumentError) do
        User.create_with_role!(email_address: "new@example.com", password: "s3cret-pass", role: "admin")
      end
    end
  end

  test "assign_role replaces the previous role" do
    user = users(:customer)

    user.assign_role(:agent)

    assert_equal [ "agent" ], user.roles.pluck(:name)
  end
end
