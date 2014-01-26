class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories  

  validates :name, presence: :true, uniqueness: :true

  before_save :generate_slug

  def generate_slug
    str = to_slug(self.name)
    cat = Category.find_by slug: str
    aux = 2

    while cat && cat != self
      str = append_suffix(str, aux)
      cat = Category.find_by slug: str
      aux += 1
    end
    
    self.slug = str
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
    str.downcase
  end

  def to_param
    self.slug    
  end
end