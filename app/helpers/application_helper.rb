module ApplicationHelper

  def show_advice temperature
    case temperature
    when 0..15 then 'Вдягніть легке осіннє пальто'
    when 15..30 then 'Вдягніть шорти та футболку'
    when -20..0 then 'Вдягніться потепліше'
    else ''
    end
  end
end
