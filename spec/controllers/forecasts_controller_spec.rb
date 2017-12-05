require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  let(:user) { User.create!(email: 'admin@example.com', password: '12345678') }

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in(user)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
  end
end