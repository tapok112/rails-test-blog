class AddUserToComment < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :user
      t.references :user, null: false, foreign_key: true
    end
  end
end
