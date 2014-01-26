class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 8}, on: :create

  before_save :generate_slug

  def generate_slug
    str = to_slug(self.username)
    user = User.find_by slug: str
    aux = 2

    while user && user != self
      str = append_suffix(str, aux)
      user = User.find_by slug: str
      aux += 1
    end
    
    self.slug = str.downcase
  end

  def append_suffix slug, count
    if slug.split('-').last.to_i != 0
      return slug.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return slug + '-' + count.to_s
    end
  end

  def to_slug name
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, "-"
    str
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