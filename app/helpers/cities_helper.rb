module CitiesHelper
  def find_coordinates(city, state)
    lat = City.find_by name: city, state: state
  end
end
