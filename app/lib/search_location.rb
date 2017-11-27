require 'open-uri'

class SearchLocation
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def location 
    @location ||= JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=AIzaSyCY05U4IKsK-Wkb38WwyZOKPgOH6s8j_JI"))
  end

  def latitude
    @latitude ||= location.first[1][0].dig('geometry','location','lat')
  end

  def longitude
    @longitude ||= location.first[1][0].dig('geometry','location','lng')
  end
end