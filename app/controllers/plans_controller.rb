class PlansController < ApplicationController
  include Common

  def new(week='next')
    @monday = date_of_monday(week)

    start_time = @monday.to_time
    @slots = create_slots(start_time, DAYNAME)
    @week = week
  end

  def create(monday, status, week)
    @monday = monday
    @plan = WeeklyPlan.where(start_date: @monday, user_id: current_user.id).first_or_create
    status.each do |time|
      @plan.time_slots.build(
        start_time: time
      )
    end
    if @plan.save
      redirect_to new_todo_path(week: week)
    else
      @slots = create_slots(@monday.to_time, DAYNAME)
      render 'new'
    end
  end

  def index(week='next')
    @week = week
    next_monday = date_of_monday(@week)

    start_time = next_monday.to_time
    @slots = create_slots(start_time, DAYNAME)

    @plan = WeeklyPlan.find_by(start_date: next_monday, user_id: current_user.id)
    if @plan.blank?
      redirect_to new_plan_path(week: week)
    end

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
