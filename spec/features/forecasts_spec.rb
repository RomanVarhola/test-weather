require 'rails_helper'

RSpec.describe "Forecasts", type: :feature do
  describe "User as guest" do
    
    it "should visit login_path" do
      visit new_user_session_path
      expect(page).to have_content('Log in')
    end

    it "should have form fields" do
      visit new_user_session_path
      page.should have_field("user_email")
      page.should have_field("user_password")
      page.should have_button("Log in")
    end

    it "shoudn't see select-form .day" do
      visit root_path
      expect(page).to_not have_css('.day')
    end
  end

  describe 'signed up user' do
    before {
      @user = User.create(email: 'vr@gmail.com', password: '12345678')
      @session = Capybara::Session.new(:rack_test, TestWeather::Application)
      @session.visit new_user_session_path
      @session.within(".panel") do
        @session.fill_in('user_email', :with => @user.email)
        @session.fill_in('user_password', :with => '12345678')
        @session.click_button("Log in")
      end
    }

    it "shoud see select-form #day" do
      @session.visit root_path
      expect(@session).to have_css('#day')
    end
  end
end