require "test_helper"
require "rake"

class UsersTaskTest < ActiveSupport::TestCase
  setup do
    Rails.application.load_tasks if Rake::Task.tasks.none?
    @task = Rake::Task["users:create"]
    @task.reenable
  end

  test "creates a user with the given email and role, password from USER_PASSWORD" do
    with_env("USER_PASSWORD" => "env-pass-123") do
      assert_output(/Created agent new-agent@example\.com/) { @task.invoke("new-agent@example.com", "agent") }
    end

    user = User.find_by!(email_address: "new-agent@example.com")
    assert_equal "agent", user.role
    assert user.authenticate("env-pass-123")
  end

  test "asks for the password with a hidden prompt when USER_PASSWORD is not set" do
    with_env("USER_PASSWORD" => nil) do
      with_stdin_password("typed-pass-123") do
        assert_output(/Created customer typed@example\.com/) { @task.invoke("typed@example.com", "customer") }
      end
    end

    assert User.find_by!(email_address: "typed@example.com").authenticate("typed-pass-123")
  end

  test "does not take the password as an argument" do
    assert_equal %i[ email role ], @task.arg_names
  end

  test "rejects an unknown role" do
    with_env("USER_PASSWORD" => "env-pass-123") do
      assert_raises(ActiveRecord::RecordInvalid) { @task.invoke("x@example.com", "admin") }
    end
    assert_nil User.find_by(email_address: "x@example.com")
  end

  private
    def with_stdin_password(password)
      original, $stdin = $stdin, Struct.new(:password) { def getpass(_prompt) = password }.new(password)
      yield
    ensure
      $stdin = original
    end
end
