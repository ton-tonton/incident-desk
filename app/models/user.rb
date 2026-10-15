class User < ApplicationRecord
  ROLES = %w[ customer agent ].freeze

  rolify
  has_secure_password reset_token: false
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ROLES, allow_blank: true }

  after_save :save_role

  def role
    @pending_role || roles.first&.name
  end

  def role=(name)
    @pending_role = name
  end

  def agent?
    role == "agent"
  end

  private
    def save_role
      if @pending_role
        self.roles = [ Role.find_or_create_by!(name: @pending_role) ]
        @pending_role = nil
      end
    end
end
