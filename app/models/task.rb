class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2 }
  enum :priority, { high: 0, medium: 1, low: 2 }
end
