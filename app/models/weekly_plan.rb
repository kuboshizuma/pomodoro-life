class WeeklyPlan < ApplicationRecord
  has_many :time_slots
  accepts_nested_attributes_for :time_slots
end
