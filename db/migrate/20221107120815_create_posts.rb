class CreatePosts < ActiveRecord::Migration[7.0]
  # Создание таблицы постов в БД
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
