class TimeSlotTodosController < ApplicationController
  def new(week='next')
    @week = week
    if week == 'next'
      @next_monday = Date.today.beginning_of_week + 1.week
    else week == 'this'
      @next_monday = Date.today.beginning_of_week
    end
  end

  def create(week='next')
    if week == 'next'
      @next_monday = Date.today.beginning_of_week + 1.week
    else week == 'this'
      @next_monday = Date.today.beginning_of_week
    end
    plan = WeeklyPlan.find_by(user_id: current_user.id, start_date: @next_monday)

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
