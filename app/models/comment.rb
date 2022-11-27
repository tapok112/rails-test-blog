class Comment < ApplicationRecord
  # Тело комментария не может быть пустым
  validates_presence_of :body
  # Связь включающая атрибуты таблицы постов в таблицу комментариев
  belongs_to :post
  # Связь включающая атрибуты таблицы пользователей в таблицу комментариев
  belongs_to :user
end
