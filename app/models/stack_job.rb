class StackJob
  attr_accessor :url, :xml, :geojson

  require 'active_support/core_ext/hash/conversions'
  require 'open-uri'
  require 'city'

  def initialize( term, min_ex, max_ex, job_type )
    @url = "https://stackoverflow.com/jobs/feed?"\
          "q=#{term}"\
          "&ms=#{min_ex}"\
          "&mxs=#{max_ex}"\
          "&j=#{job_type}"\
          "&l=United%20States&d=20&u=Miles" # Currently the application only supports US
    @xml = Nokogiri::XML(open(url))
    to_geojson
  end

  def to_geojson
      hash = Hash.from_xml(@xml.to_s)
      items = hash['rss']['channel']['item']
      json = Hash.new
      json["type"] = "FeatureCollection"
      features = Array.new
      items.each do | item |
          scs = City.split_city_state item["location"]
          city_loc = City.find_coordinates(scs[0],scs[1])
          if city_loc.nil? then city_loc = City.find_coordinates("not found", "us") end

          feature = { "type"           => "Feature",
                      "properties"     => {
                          "show_on_map"  => "true",
                          "link"         => item['link'],
                          "name"         => item['title'],
                          "company"      => item['author']['name'],
                          "city"         => item['location'],
                          "category"     => ['test'],
                          "date"         => item['pubDate']
                         },
                      "geometry"       => {
                          "type"         => "Point",
                          "coordinates"  => [ city_loc.long, city_loc.lat ]
                         }
                    }
          features.push( feature )

      end
      json["features"] = features
      @geojson = json.to_json
      @geojson
  end
end
