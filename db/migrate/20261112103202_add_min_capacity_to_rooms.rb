class AddMinCapacityToRooms < ActiveRecord::Migration[8.1]
  def change
    add_column :rooms, :min_capacity, :integer, null: false
  end
end
