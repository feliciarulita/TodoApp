require "digest"

class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  before_save :encrypt_password

  def encrypt_password
    self.password_digest = Digest::SHA256.hexdigest(password_digest) if password_digest_changed?
  end

  def valid_password?(input_password)
    Digest::SHA256.hexdigest(input_password) == self.password_digest
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return user if user && user.valid_password?(password)
    nil
  end
end
