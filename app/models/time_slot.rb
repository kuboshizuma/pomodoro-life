class TimeSlot < ApplicationRecord
  belongs_to :weekly_plan
  validates :start_time, uniqueness: { scope: [:weekly_plan_id] }
end
