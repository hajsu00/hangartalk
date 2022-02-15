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

  # 離陸時刻の日付をユーザーが入力した日付に合わせる
  def fix_inputed_time(model_name, column_name)
    inputed_time = Time.parse(params[model_name][column_name])
    inputed_date = Date.parse(params[model_name][:date])
    Time.local(inputed_date.year, inputed_date.month, inputed_date.day, inputed_time.hour, inputed_time.min, 0, 0)
  end
end
