require 'open-uri'

class GetAddress
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def location
    @location ||= JSON.load(open("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&sensor=true"))
  end

  def address
    @address ||= location.first[1][1].dig("address_components")[2].dig("long_name") + ', ' + location.first[1][1].dig("address_components")[0].dig("long_name") unless location.dig('error_message').present?
  end
end