class AddUserIdToReports < ActiveRecord::Migration[6.0]
  def up
    execute "DELETE FROM reports;"
    add_column :reports, :user_id, :integer
    change_column :reports, :user_id, :integer, index: true, null: false
    add_foreign_key :reports, :users
  end

  def down
    remove_column :books, :user, index: true
  end
end
