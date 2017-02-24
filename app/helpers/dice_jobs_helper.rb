module DiceJobsHelper
  def split_city_state(location)
    location.split(", ")
  end
end
