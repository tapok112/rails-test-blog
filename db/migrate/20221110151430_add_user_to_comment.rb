class AddUserToComment < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :user
      t.belongs_to :user
    end
  end
end
