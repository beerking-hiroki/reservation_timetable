class CreateSlots < ActiveRecord::Migration[8.1]
  def change
    create_table :slots do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :kind, null: false
      t.integer :status, null: false, default: 0
      t.string :name
      t.string :tel
      t.integer :headcount
      t.string :plan
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false

      t.timestamps
    end
  end
end
