class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: :user_id, class_name: :User
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  after_validation :generate_slug

  def generate_slug
    str = to_slug(self.title)
    post = Post.find_by slug: str
    aux = 2

    while post && post != self
      str = append_suffix(str, aux)
      post = Post.find_by slug: str
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
end