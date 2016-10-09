class Todo < ApplicationRecord
  has_many :time_slot_todos
  validates :name, uniqueness: true
end
