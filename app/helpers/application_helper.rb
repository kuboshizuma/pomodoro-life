module ApplicationHelper
  def week_name(week)
    if week == 'this'
      "今週"
    else week == 'next'
      "来週"
    end
  end
end
