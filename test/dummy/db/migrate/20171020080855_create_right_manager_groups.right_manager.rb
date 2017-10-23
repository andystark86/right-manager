# This migration comes from right_manager (originally 20171019111232)
class CreateRightManagerGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :right_manager_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
