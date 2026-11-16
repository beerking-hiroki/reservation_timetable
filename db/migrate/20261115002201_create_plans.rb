class CreatePlans < ActiveRecord::Migration[8.1]
  def change
    create_table :plans do |t|
      t.references :store, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :duration_minutes
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
