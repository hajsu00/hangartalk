module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Hanger Talk"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # フライトタイムを「◯◯：◯◯」形式でビューに表示する
  def show_flight_time(time)
    hour = time.div(3600)
    min = (time % 3600) / 60
    "#{hour}:#{format('%02d', min)}"
  end
end
