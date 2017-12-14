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
    @address ||= begin
      raise ArgumentError.new(I18n.t('address.error_show')) unless location.is_a?(Hash) && !(location.dig('error_message').present?)
      location.first[1][1].dig("address_components")[2].dig("long_name") + ', ' + location.first[1][1].dig("address_components")[0].dig("long_name")
    end
  end
end