class CreateRightManagerRights < ActiveRecord::Migration[5.0]
  def change
    create_table :right_manager_rights do |t|
      t.string :name
      t.text :description
      t.integer :group_id, index: true

      t.timestamps
    end
  end
end
