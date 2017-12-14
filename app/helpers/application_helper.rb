module ApplicationHelper

  def show_advice temperature
    case temperature
    when 5..15 then I18n.t('weather.autumn')
    when 15..35 then I18n.t('weather.summer')
    when -40..5 then I18n.t('weather.winter')
    else ''
    end
  end
end
