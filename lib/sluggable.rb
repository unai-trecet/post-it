module Sluggable
  extend ActiveSupport::Concern

  included do
     before_save :generate_slug
     class_attribute :slug_column
  end

  def generate_slug
    slug = to_slug(self.send(self.class.slug_column.to_sym))
    obj = self.class.find_by slug: slug
    aux = 2

    while obj && obj != self
      slug = append_suffix(slug, aux)
      obj = self.class.find_by slug: slug
      aux += 1
    end
    
    self.slug = slug.downcase
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

  module ClassMethods   
    def sluggable_column col_name
      self.slug_column = col_name
    end
  end

  def to_param
    self.slug
  end
end