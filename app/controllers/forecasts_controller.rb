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
    @forecast = current_user.forecasts.new
    forecast_params

    respond_to do |format|
      if @forecast.save
        format.html { redirect_to root_path, notice: 'Forecast was created.' }
        format.json { render :show, status: :created, location: @forecast }
      else
        format.html { redirect_to root_path, notice: "Forecast wasn't created." }
        format.json { render json: @forecast.errors, status: :unprocessable_entity }
      end
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
