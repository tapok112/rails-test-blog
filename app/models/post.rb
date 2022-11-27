# Модель поста
class Post < ApplicationRecord
  # Тело и заголовок поста не могут быть пустыми
  validates_presence_of :title, :body
  # Заголовок поста должен быть уникальным 
  validates_uniqueness_of :title
  # Связь один-к-одному между таблицей постов и таблицей active storage
  has_one_attached :image
  # Связь один-ко многим между таблицей постов и таблицей комментариев
  has_many :comments, dependent: :destroy

  # Объявление метода модели для фильтрации списка постов по определенному пользователю  
  scope :by_user, -> (user_id) {
    where user_id: user_id if user_id.present?
  }

  paginates_per 15
end
