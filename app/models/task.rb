class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2 }
  enum :priority, { high: 0, medium: 1, low: 2 }

  validates :name, presence: true, length: { maximum: 100 }
  validates :status, presence: true
  validates :priority, presence: true
  validates :create_time, presence: true
  validates :end_time, comparison: { greater_than: :create_time }
end
