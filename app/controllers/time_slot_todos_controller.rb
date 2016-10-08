class TimeSlotTodosController < ApplicationController
  include Common

  def new(week='next')
    @week = week
    @monday = date_of_monday(week)
  end

  def create(week='next')
    @monday = date_of_monday(week)

    plan = WeeklyPlan.find_by(user_id: current_user.id, start_date: @monday)

    todos = plan.todos
    time_slots = plan.time_slots

    assignment = []
    todos.each do |todo|
      slot_num = (todo.hours/0.5).to_i
      slot_num.times do
        assignment.append(todo.id)
      end
    end

    assignment.shuffle!
    assignment.each.with_index do |task_id, i|
      TimeSlotTodo.where(
        time_slot_id: time_slots[i]
      ).first_or_create(
        todo_id: task_id,
        weekly_plan_id: plan.id
      )
    end
    redirect_to root_path
  end
end
