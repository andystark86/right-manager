# This migration comes from right_manager (originally 20171002070151)
class CreateRightManagerUsersRights < ActiveRecord::Migration[5.0]
  def change
    create_table :right_manager_users_rights do |t|
      t.integer :user_id, index: true
      t.integer :right_id, index: true
      t.integer :access_level

      t.timestamps
    end
  end
end
