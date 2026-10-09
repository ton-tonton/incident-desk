namespace :users do
  desc "Create a user. Usage: bin/rails \"users:create[email,role]\". " \
       "The password is read from USER_PASSWORD, or asked for with a hidden prompt."
  task :create, %i[ email role ] => :environment do |_task, args|
    abort "Usage: bin/rails \"users:create[email,role]\" (role: #{User::ROLES.join(" or ")})" if args[:email].blank? || args[:role].blank?
    abort "Unknown role: #{args[:role]}. Use one of: #{User::ROLES.join(", ")}" unless User::ROLES.include?(args[:role])

    password = ENV["USER_PASSWORD"].presence || begin
      require "io/console"
      abort "Set USER_PASSWORD or run in an interactive terminal." unless $stdin.tty?
      $stdin.getpass("Password: ")
    end

    user = User.create_with_role!(email_address: args[:email], password: password, role: args[:role])
    puts "Created #{user.role} #{user.email_address}"
  rescue ActiveRecord::RecordInvalid => e
    abort "Could not create user: #{e.record.errors.full_messages.to_sentence}"
  end
end
