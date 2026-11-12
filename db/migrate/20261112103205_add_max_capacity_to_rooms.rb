class AddMaxCapacityToRooms < ActiveRecord::Migration[8.1]
  def change
    add_column :rooms, :max_capacity, :integer, null: false
  end
end
