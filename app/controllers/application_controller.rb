class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :weekly_plan_status

  def weekly_plan_status
    @is_next_week_plan = WeeklyPlan.exists?(user_id: current_user.id, start_date: Date.today.beginning_of_week + 1.week)
    @is_this_week_plan = WeeklyPlan.exists?(user_id: current_user.id, start_date: Date.today.beginning_of_week)
  end
end
