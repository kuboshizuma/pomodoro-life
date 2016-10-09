class TopController < ApplicationController
  include Common

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      monday = date_of_monday('this')
      plan = WeeklyPlan.find_by(start_date: monday, user_id: current_user.id)
      if plan.blank?
        redirect_to new_plan_path
      end
      @time_slots = TimeSlot.where(weekly_plan_id: plan.id).where(start_time: [Date.today..Date.tomorrow]).includes(todos: :time_slot_todos)
    end
  end
end
