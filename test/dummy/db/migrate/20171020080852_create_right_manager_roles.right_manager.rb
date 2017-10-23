# This migration comes from right_manager (originally 20170926125302)
class CreateRightManagerRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :right_manager_roles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
