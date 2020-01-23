require 'test_helper'

class CityTest < ActiveSupport::TestCase
  test "find one" do
    assert_equal "new york", cities(:new_york).name
  end

  test "split_city_state" do
    split = City.split_city_state("new york, ny")
    assert_equal "new york", split[0]
    assert_equal "ny", split[1]
  end

  test "find_coordinates" do
    coord = City.find_coordinates("new york", "ny")
    assert_equal 40.71427, coord.lat
    assert_equal (-74.00597) , coord.long
  end
end
