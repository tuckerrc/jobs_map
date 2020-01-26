require 'test_helper'

class StackJobTest < ActiveSupport::TestCase
  test "to_geojson" do
    assert_equal '{"type":"FeatureCollection","features":[{"type":"Feature","properties":{"show_on_map":"true","link":"https://example.com/link","name":"title (city, st)","company":"Author","city":"City, ST","category":["ruby","postgresql","javascript","ruby-on-rails"],"date":"2020-01-06T21:37:34"},"geometry":{"type":"Point","coordinates":[-71.68,29.85]}},{"type":"Feature","properties":{"show_on_map":"true","link":"https://example.com/link","name":"title (city, st)","company":"Author","city":"City, ST","category":["ruby","postgresql","javascript","ruby-on-rails"],"date":"2020-01-06T21:37:34"},"geometry":{"type":"Point","coordinates":[-71.68,29.85]}}]}', stack_jobs(:test_jobs).to_geojson
  end
end
