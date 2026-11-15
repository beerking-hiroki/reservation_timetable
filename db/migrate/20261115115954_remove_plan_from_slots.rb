class RemovePlanFromSlots < ActiveRecord::Migration[8.1]
  def change
    remove_column :slots, :plan, :string
  end
end
