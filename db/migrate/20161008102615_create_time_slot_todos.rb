class CreateTimeSlotTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :time_slot_todos do |t|
      t.references :time_slot
      t.references :todo

      t.timestamps
    end
  end
end
