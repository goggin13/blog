class Post
  include HyperMapper::Document

  attr_accessible :title, :content, :user_id, :published

  autogenerate_id
  attribute :title
  attribute :content
  attribute :user_id
  attribute :published, type: :datetime

  timestamps

  validates :title, presence: true
  validates :user_id, presence: true
  validates :content, presence: true

  belongs_to :user
end
