require 'rails_helper'

RSpec.describe "forecasts/show", type: :view do
  before(:each) do
    @forecast = assign(:forecast, Forecast.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
