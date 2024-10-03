class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: { employee: 0, hr: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  validates :onboarding_status, inclusion: { in: %w[not_started in_progress completed] }, allow_nil: true
       
  def self.from_omniauth(auth)
    user = User.find_or_initialize_by(email: auth.info.email)

    if user.persisted? && (user.provider != auth.provider || user.uid != auth.uid)
      user.provider = auth.provider
      user.uid = auth.uid
    end

    if user.new_record? || user.provider_changed? || user.uid_changed?
      user.password = Devise.friendly_token[0, 20]
    end

    user.save!
    user
  end
end
