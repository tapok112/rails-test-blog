class AddUserIdToPost < ActiveRecord::Migration[7.0]
  # Создание связи таблицы постов с таблицей пользователей в БД
  def change
    change_table :posts do |t|
      t.belongs_to :user
    end
  end
end
