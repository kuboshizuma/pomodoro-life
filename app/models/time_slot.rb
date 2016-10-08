class TimeSlot < ApplicationRecord
  belongs_to :weekly_plan
  has_many :time_slot_todos
  has_many :todos, through: :time_slot_todos
  validates :start_time, uniqueness: { scope: [:weekly_plan_id] }
end
