class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  before_destroy :ensure_admin_remains

  def self.authenticateUser(email, password)
    user = find_by(email: email)
    return user if user&.authenticate(password)
    nil
  end

  def ensure_admin_remains
    if manager? && User.where(manager: true).count <= 1
      throw :abort
    end
  end
end
