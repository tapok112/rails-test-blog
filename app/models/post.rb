class Post < ApplicationRecord
  validates :title, :body, presence:true
  has_one_attached :post_image
end
