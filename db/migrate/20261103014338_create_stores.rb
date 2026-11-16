class CreateStores < ActiveRecord::Migration[8.1]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :crypted_password, null: false
      t.time :open_time, null: false
      t.time :close_time, null: false

      t.timestamps
    end
  end
end
