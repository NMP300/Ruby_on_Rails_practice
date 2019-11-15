class AddUserIdToBooks < ActiveRecord::Migration[6.0]
  def up
    execute "DELETE FROM books;"
    add_column :books, :user_id, :integer
    change_column :books, :user_id, :integer, index: true, null: false
  end

  def down
    remove_column :books, :user, index: true
  end
end
