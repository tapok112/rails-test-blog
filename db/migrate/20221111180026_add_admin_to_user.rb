class AddAdminToUser < ActiveRecord::Migration[7.0]
  # Добавление поля admin и name в таблицу пользователей
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :name, :string
  end
end
