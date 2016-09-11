class AddUserIdToJobs < ActiveRecord::Migration
  def up
    add_column(:jobs, :user_id, :integer)
    execute('UPDATE jobs SET user_id = (SELECT id FROM users LIMIT 1)')
    change_column_null(:jobs, :user_id, false)
    add_foreign_key(:jobs, :users)
  end

  def down
    remove_column(:jobs, :user_id)
  end
end
