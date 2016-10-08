module Common
  extend ActiveSupport::Concern

  dayname = Date::ABBR_DAYNAMES.dup
  dayname.append(dayname.shift)
  DAYNAME = dayname

  def date_of_monday(week)
    if week == 'next'
      Date.today.beginning_of_week + 1.week
    else week == 'this'
      Date.today.beginning_of_week
    end
  end
end
