class ForecastsController < ApplicationController
  before_action :set_forecast, only: [:show, :edit, :destroy]

  def index
    if params[:search].present?
      search_params
    elsif cookies[:lat].present? && cookies[:lng].present?
      cookies_params
    end

    if current_user
      @forecast = current_user.forecasts.last 
      @forecasts = current_user.forecasts.order('created_at desc')
    elsif @latitude && @longitude
      weather = GetWeather.new(@latitude, @longitude, @day)
      @temperature = weather.temperature
      @description = weather.description
      @date = weather.date
    end
  end

  def create
    begin
      CreateForecast.new(current_user, params, cookies).call
      flash[:notice] = 'Forecast was successfully created.'
      redirect_to root_path
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to root_path
    end
  end

  def destroy
    @forecast.destroy
    respond_to do |format|
      format.html { redirect_to forecasts_url, notice: 'Forecast was destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_forecast
      @forecast = current_user.forecasts.find(params[:id])
    end

    def search_params
      sl = SearchLocation.new(params[:search])
      @address = params[:search]
      @latitude = sl.latitude
      @longitude = sl.longitude
      @day = params[:day].to_i
    end

    def cookies_params
      @latitude = cookies[:lat].to_f
      @longitude = cookies[:lng].to_f
      @address = GetAddress.new(@latitude, @longitude).address
      @day = 0
    end
end
