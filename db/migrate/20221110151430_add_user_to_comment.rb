class AddUserToComment < ActiveRecord::Migration[7.0]
  # Создание связи таблицы комментариев с таблицей пользователей в БД
  def change
    change_table :comments do |t|
      t.remove :user
      t.belongs_to :user
    end
  end
end
