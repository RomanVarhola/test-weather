class HomesController < ApplicationController
  def index
    if params[:search].present?
      sl = SearchLocation.new(params[:search])
      @address = params[:search]
      @latitude = sl.latitude
      @longitude = sl.longitude
      @day = params[:day].to_i
    elsif cookies[:lat].present? && cookies[:lng].present?
      @latitude = cookies[:lat].to_f
      @longitude = cookies[:lng].to_f
      @address = GetAddress.new(@latitude, @longitude).address
      @day = 1
    end

    if @latitude && @longitude
      weather = GetWeather.new(@latitude, @longitude, @day)
      @temperature = weather.temperature
      @description = weather.description
      @date = weather.date
    end
  end
end
