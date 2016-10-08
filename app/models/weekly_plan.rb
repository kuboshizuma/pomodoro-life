class WeeklyPlan < ApplicationRecord
  has_many :time_slots
  has_many :todos
  accepts_nested_attributes_for :time_slots
end
