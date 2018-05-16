# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :password_digest, :session_token, :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  before_validation :ensure_session_token

  attr_reader :password

  has_many :posts,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :Post

  has_many :subs,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :Sub

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil unless user && user.has_password?(password)
    user
  end

  def has_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  private
  def generate_session_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end


end
