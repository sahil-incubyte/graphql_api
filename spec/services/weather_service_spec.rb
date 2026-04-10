require 'rails_helper'

RSpec.describe WeatherService do
  it "fetches weather" do
    VCR.use_cassette("weather") do
      result = WeatherService.fetch("Pune")
      debugger
      expect(result).to be_a(Hash)
    end
  end
end
