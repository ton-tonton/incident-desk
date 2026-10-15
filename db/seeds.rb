# Demo users for local use. Passwords come from env vars, never from this file.
#
#   DEMO_CUSTOMER_PASSWORD=... DEMO_AGENT_PASSWORD=... bin/rails db:seed
#
# A demo user whose password var is not set is skipped.
{ "customer" => "demo-customer@example.com", "agent" => "demo-agent@example.com" }.each do |role, email|
  prefix = "DEMO_#{role.upcase}"
  password = ENV["#{prefix}_PASSWORD"]

  if password.present?
    user = User.find_or_initialize_by(email_address: email)
    user.update!(password: password, role: role)
    puts "Seeded #{role} #{user.email_address}"
  else
    puts "Skipped demo #{role}: #{prefix}_PASSWORD is not set"
  end
end
