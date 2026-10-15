require "io/console"

namespace :users do
  desc "Create a user: bin/rails \"users:create[email,role]\". Password from USER_PASSWORD or a hidden prompt"
  task :create, %i[ email role ] => :environment do |_task, args|
    password = ENV["USER_PASSWORD"].presence || $stdin.getpass("Password: ")
    user = User.create!(email_address: args[:email], role: args[:role], password: password)

    puts "Created #{user.role} #{user.email_address}"
  end
end
