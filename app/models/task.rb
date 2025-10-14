class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2 }
  enum :priority, { high: 2, medium: 1, low: 0 }

  validates :name, presence: true, length: { maximum: 100 }
  validates :status, presence: true
  validates :priority, presence: true
  validates :create_time, presence: true
  validates :end_time, comparison: { greater_than: :create_time }

  scope :sorted, ->(sort_column, sort_direction) {
    allowed_columns = %w[create_time end_time id priority]
    allowed_directions = %w[asc desc]

    column = allowed_columns.include?(sort_column) ? sort_column : "create_time"
    direction = allowed_directions.include?(sort_direction) ? sort_direction : "asc"

    order(column => direction)
  }

  def self.ransackable_attributes(auth_object = nil)
    %w[name status create_time end_time id]
  end
end
