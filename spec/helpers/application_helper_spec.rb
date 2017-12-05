require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#show_advice" do
    it "displays the advice by temperature +1C" do
      temperature = 1
      expect(helper.show_advice(temperature)).to match I18n.t('weather.autumn')
    end

    it "displays the advice by temperature -5C" do
      temperature = -5
      expect(helper.show_advice(temperature)).to match I18n.t('weather.winter')
    end

    it "displays the advice by temperature +20C" do
      temperature = 20
      expect(helper.show_advice(temperature)).to match I18n.t('weather.summer')
    end
  end
end