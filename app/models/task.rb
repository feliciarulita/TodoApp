class Task < ApplicationRecord
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  enum :status, { pending: 0, in_progress: 1, completed: 2 }
  enum :priority, { high: 2, medium: 1, low: 0 }

  validates :name, presence: true, length: { maximum: 100 }
  validates :status, presence: true
  validates :priority, presence: true
  validates :create_time, presence: true
  validates :end_time, comparison: { greater_than: :create_time }

  ALLOWED_COLUMNS = %w[create_time end_time id priority].freeze
  ALLOWED_DIRECTIONS = %w[asc desc].freeze

  scope :sorted, ->(sort_column, sort_direction) {
    column = ALLOWED_COLUMNS.include?(sort_column) ? sort_column : "create_time"
    direction = ALLOWED_DIRECTIONS.include?(sort_direction) ? sort_direction : "asc"

    order(column => direction)
  }

  scope :with_tags, ->(tag_ids) {
    if tag_ids.present?
      joins(:tags).where(tags: { id: tag_ids }).distinct
    else
      all
    end
  }


  def self.ransackable_attributes(auth_object = nil)
    %w[name status create_time end_time id tags]
  end
end
