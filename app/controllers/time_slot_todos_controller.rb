class TimeSlotTodosController < ApplicationController
  def new
  end

  def create
    plan = WeeklyPlan.where(user_id: current_user.id).order(start_date: :DESC).first
    if plan.start_date < Date.today.to_time
      redirect_to new_plan_path
    end

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
