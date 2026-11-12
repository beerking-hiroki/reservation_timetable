class RemoveCapacityFromRooms < ActiveRecord::Migration[8.1]
  def change
    remove_column :rooms, :capacity, :string
  end
end
