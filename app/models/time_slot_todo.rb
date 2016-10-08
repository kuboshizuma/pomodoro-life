class TimeSlotTodo < ApplicationRecord
  belongs_to :todo
  belongs_to :time_slot
end
