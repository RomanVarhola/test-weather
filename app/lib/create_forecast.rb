class CreateForecast
  attr_reader :params, :cookies, :current_user

  def initialize(current_user, params, cookies)
    @params = params
    @cookies = cookies
    @current_user = current_user
  end

  def call
    @forecast = current_user.forecasts.new
    forecast_params
    raise(NotValidEntryRecord, @forecast.errors.full_messages.to_sentence) unless @forecast.save  
  end

  def forecast_params
    if params[:search].present?
      sl = SearchLocation.new(params[:search])
      @forecast.address = params[:search]
      @latitude = sl.latitude
      @longitude = sl.longitude
      @day = params[:day].to_i
    elsif cookies[:lat].present? && cookies[:lng].present?
      @latitude = cookies[:lat].to_f
      @longitude = cookies[:lng].to_f
      @forecast.address = GetAddress.new(@latitude, @longitude).address
      @day = current_user ? params[:day].to_i : 0
    end

    if @latitude && @longitude
      weather = GetWeather.new(@latitude, @longitude, @day)
      @forecast.temperature = weather.temperature
      @forecast.description = weather.description
      @forecast.date = weather.date
    end
  end
end
