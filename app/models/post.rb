class Post < ApplicationRecord
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  has_one_attached :image
  has_many :comments, dependent: :destroy

  scope :by_user, -> (user) {
    where(:user_id => user)
  }

  paginates_per 15
end
