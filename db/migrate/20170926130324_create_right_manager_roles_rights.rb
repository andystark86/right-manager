class CreateRightManagerRolesRights < ActiveRecord::Migration[5.0]
  def change
    create_table :right_manager_roles_rights do |t|
      t.integer :role_id, index: true
      t.integer :right_id, index: true
      t.integer :access_level

      t.timestamps
    end
  end
end
