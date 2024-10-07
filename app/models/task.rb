class Task < ApplicationRecord
  belongs_to :assigned_to, class_name: 'User'
  has_one_attached :document

  validates :title, presence: true
  validates :status, inclusion: { in: %w[completed pending upcoming] }

  scope :completed, -> { where(status: 'completed') }
  scope :pending, -> { where(status: 'pending') }
  scope :upcoming, -> { where('due_date > ?', Date.today) }
end
