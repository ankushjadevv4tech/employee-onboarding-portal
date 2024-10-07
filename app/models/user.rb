class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tasks, foreign_key: :assigned_to_id, dependent: :destroy

  before_validation :set_default_role, on: :create
  before_validation :set_default_password, on: :create

  enum role: { employee: 0, hr: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  validates :onboarding_status, inclusion: { in: %w[not_started in_progress completed] }, allow_nil: true

  scope :employees, -> { where(role: 'employee') }

  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(email: auth.info.email)

    if user.persisted? && (user.provider != auth.provider || user.uid != auth.uid)
      user.provider = auth.provider
      user.uid = auth.uid
    elsif user.new_record? || user.provider_changed? || user.uid_changed?
      user.password = Devise.friendly_token[0, 20]
    end

    user.save!
    user
  end

  private

  def set_default_role
    self.role ||= 'employee'  # Set the role to 'employee' if not already set
  end

  def set_default_password
    self.password ||= Devise.friendly_token[0, 20]  # Set a default password if not provided
  end
end
