require "test_helper"
require "rake"

class UsersRakeTest < ActiveSupport::TestCase
  setup do
    unless Rake::Task.task_defined?("users:create")
      Rake::Task.define_task(:environment)
      load Rails.root.join("lib/tasks/users.rake")
    end
    @task = Rake::Task["users:create"]
    @task.reenable
  end

  test "creates a user with the password from USER_PASSWORD" do
    with_env("USER_PASSWORD" => "s3cret-pass") do
      assert_output(/Created agent new@example.com/) { @task.invoke("new@example.com", "agent") }
    end

    user = User.find_by!(email_address: "new@example.com")
    assert user.agent?
    assert user.authenticate("s3cret-pass")
  end

  test "rejects an unknown role" do
    with_env("USER_PASSWORD" => "s3cret-pass") do
      _out, err = capture_io do
        assert_raises(SystemExit) { @task.invoke("new@example.com", "admin") }
      end
      assert_match(/Unknown role/, err)
    end

    assert_not User.exists?(email_address: "new@example.com")
  end

  test "does not take the password as an argument" do
    assert_equal [ :email, :role ], @task.arg_names
  end

  private
    def with_env(vars)
      old = vars.keys.index_with { |key| ENV[key] }
      vars.each { |key, value| ENV[key] = value }
      yield
    ensure
      old.each { |key, value| ENV[key] = value }
    end
end
