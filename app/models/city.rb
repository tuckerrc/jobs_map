class City < ApplicationRecord
  validates :name, uniqueness: { scope: :state,
    message: "One [City, State] pair" }

  def self.find_coordinates(city, state)
    City.where("lower(name) = ? and lower(state) = ?",city.downcase, state.downcase).first
  end

  def self.split_city_state(location)
    location.split(", ")
  end
end
