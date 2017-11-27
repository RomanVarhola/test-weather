require 'open-uri'

class GetWeather
  attr_reader :latitude, :longitude, :day

  def initialize(latitude, longitude, day)
    @latitude = latitude
    @longitude = longitude
    @day = day
  end

  def weather
    @weather ||= JSON.load(open("https://business.weatherbug.com/api/forecasts/daily?includeObservation=true&lat=#{latitude}&lng=#{longitude}&timestamp=1510824671035"))
  end

  def temperature
    @temperature ||= weather[day].dig('Night','Temperature')
  end

  def description
    @description ||= weather[day].dig('Night','DetailedDescription')
  end

  def date
    @date ||= weather[day].dig('Night', 'ForecastDateLocalStr')
  end
end