class Todo < ApplicationRecord
  validates :name, uniqueness: true
end
