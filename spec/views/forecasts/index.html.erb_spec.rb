require 'rails_helper'

RSpec.describe "forecasts/index", type: :view do
  before(:each) do
    assign(:forecasts, [
      Forecast.create!(),
      Forecast.create!()
    ])
  end

  it "renders a list of forecasts" do
    render
  end
end
