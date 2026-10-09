# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Demo users. Passwords come from environment variables and are never stored in code.
# A demo user is skipped when its password variable is not set.
{
  "customer" => { email: ENV.fetch("DEMO_CUSTOMER_EMAIL", "customer@example.com"), password: ENV["DEMO_CUSTOMER_PASSWORD"] },
  "agent" => { email: ENV.fetch("DEMO_AGENT_EMAIL", "agent@example.com"), password: ENV["DEMO_AGENT_PASSWORD"] }
}.each do |role, demo|
  if demo[:password].blank?
    puts "Skipping demo #{role}: set DEMO_#{role.upcase}_PASSWORD to create it."
    next
  end

  user = User.find_or_initialize_by(email_address: demo[:email])
  user.update!(password: demo[:password])
  user.assign_role(role)
  puts "Seeded demo #{role} #{user.email_address}"
end
