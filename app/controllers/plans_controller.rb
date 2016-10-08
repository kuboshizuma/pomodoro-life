class PlansController < ApplicationController

  def new(week='next')
    if week == 'next'
      @next_monday = Date.today.beginning_of_week + 1.week
    else week == 'this'
      @next_monday = Date.today.beginning_of_week
    end
    dayname = Date::ABBR_DAYNAMES.dup
    dayname.append(dayname.shift)

    start_time = @next_monday.to_time
    @slots = create_slots(start_time, dayname)
    @week = week
  end

  def create(next_monday, status, week)
    @next_monday = next_monday
    @plan = WeeklyPlan.where(start_date: @next_monday, user_id: current_user.id).first_or_create
    status.each do |time|
      @plan.time_slots.build(
        start_time: time
      )
    end
    if @plan.save
      redirect_to new_todo_path(week: week)
    else
      dayname = Date::ABBR_DAYNAMES.dup
      dayname.append(dayname.shift)
      @slots = create_slots(next_monday.to_time, dayname)
      render 'new'
    end
  end

  def index(week='next')
    if week == 'next'
      next_monday = Date.today.beginning_of_week + 1.week
    elsif week == 'this'
      next_monday = Date.today.beginning_of_week
    end
    dayname = Date::ABBR_DAYNAMES.dup
    dayname.append(dayname.shift)

    start_time = next_monday.to_time
    @slots = create_slots(start_time, dayname)

    @plan = WeeklyPlan.find_by(start_date: next_monday, user_id: current_user.id)

    @start_times = []
    @slot_todos = {}
    time_slots = TimeSlot.where(weekly_plan: @plan.id).includes(:todos)
    time_slots.each do |time_slot|
      if !time_slot.todos[0].nil?
        @start_times.append(time_slot.start_time)
        @slot_todos[time_slot.start_time] = time_slot.todos[0]
      end
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
