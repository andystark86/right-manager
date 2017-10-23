class CreateRightManagerGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :right_manager_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
