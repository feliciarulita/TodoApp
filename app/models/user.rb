class User < ApplicationRecord
  has_secure_password
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.authenticateUser(email, password)
    user = find_by(email: email)
    return user if user&.authenticate(password)
    nil
  end
end
