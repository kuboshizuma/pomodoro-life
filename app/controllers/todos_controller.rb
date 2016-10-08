class TodosController < ApplicationController
  def new(week='next')
    if week == 'next'
      @next_monday = Date.today.beginning_of_week + 1.week
    else week == 'this'
      @next_monday = Date.today.beginning_of_week
    end
    @plan = WeeklyPlan.find_by(user_id: current_user.id, start_date: @next_monday)
    slots = @plan.time_slots
    @slots_count = slots.count
    @select_options = []
    @slots_count.times.with_index do |i|
      @select_options.append((i+1)*0.5)
    end
    @week = week
  end

  def create(todo, plan_id, max_time, week)
    hours = 0
    decided_todos = Todo.where(weekly_plan_id: plan_id)
    decided_time = decided_todos.inject(0){|sum, decided_todo| sum + decided_todo.hours}

    todo.each.with_index(1) do |parameter, i|
      if parameter[:name].present? && parameter[:hours].present?
        hours += parameter[:hours].to_f
        if hours > max_time.to_f - decided_time
          break
        end
        Todo.create(
          name: parameter[:name],
          hours: parameter[:hours].to_f,
          weekly_plan_id: plan_id,
          priority: i
        )
      end
    end
    redirect_to new_time_slot_todo_path(week: week)
  end

end
