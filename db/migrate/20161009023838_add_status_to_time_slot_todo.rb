class AddStatusToTimeSlotTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :time_slot_todos, :status, :boolean, default: false
  end
end
