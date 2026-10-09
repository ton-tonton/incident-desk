class User < ApplicationRecord
  ROLES = %w[ customer agent ].freeze

  rolify
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.create_with_role!(role:, **attributes)
    transaction do
      create!(attributes).tap { |user| user.assign_role(role) }
    end
  end

  # A user has exactly one of ROLES, so assigning a role replaces the old one.
  def assign_role(role)
    role = role.to_s
    raise ArgumentError, "Unknown role: #{role.inspect}. Use one of: #{ROLES.join(", ")}" unless ROLES.include?(role)

    transaction do
      (ROLES - [ role ]).each { |other| remove_role(other) }
      add_role(role)
    end
  end

  def role
    roles.where(name: ROLES).pick(:name)
  end

  def customer?
    role == "customer"
  end

  def agent?
    role == "agent"
  end
end
