module CitiesHelper
  def find_coordinates(city, state)
    City.where("lower(name) = ? and lower(state) = ?",city.downcase, state.downcase).first
  end
end
