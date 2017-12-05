require 'rails_helper'

RSpec.describe "forecasts/edit", type: :view do
  before(:each) do
    @forecast = assign(:forecast, Forecast.create!())
  end

  it "renders the edit forecast form" do
    render

    assert_select "form[action=?][method=?]", forecast_path(@forecast), "post" do
    end
  end
end
