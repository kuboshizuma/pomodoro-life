class PlansController < ApplicationController

  def new
    @next_monday = Date.today.beginning_of_week + 1.week
    dayname = Date::ABBR_DAYNAMES.dup
    dayname.append(dayname.shift)

    start_time = @next_monday.to_time
    @slots = create_slots(start_time, dayname)
  end

  def create(next_monday, status)
    @plan = WeeklyPlan.first_or_create(start_date: next_monday, user_id: current_user.id)
    status.each do |time|
      @plan.time_slots.build(
        start_time: time
      )
    end
    if @plan.save
      redirect_to new_todo_path
    else
      dayname = Date::ABBR_DAYNAMES.dup
      dayname.append(dayname.shift)
      @slots = create_slots(next_monday.to_time, dayname)
      render 'new'
    end
  end

  def index
    next_monday = Date.today.beginning_of_week + 1.week
    dayname = Date::ABBR_DAYNAMES.dup
    dayname.append(dayname.shift)

    start_time = next_monday.to_time
    @slots = create_slots(start_time, dayname)

    @plan = WeeklyPlan.first_or_create(start_date: next_monday, user_id: current_user.id)

    @start_times = []
    @slot_todos = {}
    time_slots = TimeSlot.where(weekly_plan: @plan.id).includes(:todos)
    time_slots.each do |time_slot|
      @start_times.append(time_slot.start_time)
      @slot_todos[time_slot.start_time] = time_slot.todos[0]
    end
  end

  private

  def create_slots(start_time, dayname)
    slots = []

    dayname.each do |day|
      daily_slots = []
      48.times do
        daily_slots.append(start_time)
        start_time += 30.minutes
      end
      slots.append([day, daily_slots])
    end
    return slots
  end
end
