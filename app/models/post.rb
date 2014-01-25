class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: :User
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  after_validation :generate_slugs

  def total_votes
  	self.up_vote - self.down_vote
  end

  def up_vote
  	self.votes.where(vote: true).size
  end

  def down_vote
  	self.votes.where(vote: false).size
  end

  def generate_slugs
    self.slug = self.title.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
end