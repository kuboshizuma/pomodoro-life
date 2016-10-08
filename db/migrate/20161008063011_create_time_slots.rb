class CreateTimeSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :time_slots do |t|
      t.references :weekly_plan
      t.timestamp :start_time

      t.timestamps
    end
  end
end
