class WeatherService
  BASE_URL = "https://geocoding-api.open-meteo.com/v1/search"
  WEATHER_URL = "https://api.open-meteo.com/v1/forecast"

  def self.fetch(city)
    geo = HTTParty.get(BASE_URL, query: { name: city, count: 1 })
    geo_data = JSON.parse(geo.body)

    location = geo_data["results"]&.first
    return {} unless location

    response = HTTParty.get(WEATHER_URL, query: {
      latitude: location["latitude"],
      longitude: location["longitude"],
      current_weather: true
    })
    JSON.parse(response.body)
  end
end