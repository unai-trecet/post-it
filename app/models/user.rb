class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 8}, on: :create

  before_save :generate_slug

  def generate_slug
    self.slug = self.username.gsub(" ", "-").downcase
  end

  def to_param
    self.slug    
  end

  def admin?
  	self.role == "admin"
  end

  def moderator?
  	self.role == "moderator"
  end

end