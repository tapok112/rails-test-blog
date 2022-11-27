class CreateComments < ActiveRecord::Migration[7.0]
  # Создание таблицы комментариев в БД
  def change
    create_table :comments do |t|
      t.string :user
      t.text :body
      t.belongs_to :post

      t.timestamps
    end
  end
end
