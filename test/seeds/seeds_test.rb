require "test_helper"

class SeedsTest < ActiveSupport::TestCase
  test "creates a demo customer and a demo agent with passwords from env vars" do
    with_env("DEMO_CUSTOMER_PASSWORD" => "customer-pass", "DEMO_AGENT_PASSWORD" => "agent-pass") do
      assert_output(/demo-customer@example\.com/) { Rails.application.load_seed }
    end

    customer = User.find_by!(email_address: "demo-customer@example.com")
    agent = User.find_by!(email_address: "demo-agent@example.com")
    assert_equal "customer", customer.role
    assert customer.authenticate("customer-pass")
    assert_equal "agent", agent.role
    assert agent.authenticate("agent-pass")
  end

  test "can run twice" do
    with_env("DEMO_CUSTOMER_PASSWORD" => "customer-pass", "DEMO_AGENT_PASSWORD" => "agent-pass") do
      assert_difference -> { User.count }, 2 do
        capture_io { 2.times { Rails.application.load_seed } }
      end
    end
  end

  test "skips a demo user whose password env var is not set" do
    with_env("DEMO_CUSTOMER_PASSWORD" => nil, "DEMO_AGENT_PASSWORD" => nil) do
      assert_no_difference -> { User.count } do
        assert_output(/DEMO_CUSTOMER_PASSWORD is not set/) { Rails.application.load_seed }
      end
    end
  end
end
