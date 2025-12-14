class User < ApplicationRecord
  has_secure_password
  
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :user_info, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :role, inclusion: { in: %w[user admin] }, allow_nil: true
  
  before_validation :set_default_role, on: :create
  
  private
  
  def set_default_role
    self.role ||= 'user'
  end
end
