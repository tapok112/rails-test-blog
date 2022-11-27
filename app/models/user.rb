class User < ApplicationRecord
  # Модули девайс
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Связь один-ко многим между таблицей пользователей и таблицей постов
  has_many :posts,    dependent: :destroy
  # Связь один-ко многим между таблицей пользователей и таблицей комментариев
  has_many :comments, dependent: :destroy
end
