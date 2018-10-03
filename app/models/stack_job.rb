class StackJob
  attr_accessor :url, :xml, :geojson

  require 'active_support/core_ext/hash/conversions'
  require 'open-uri'
  require 'city'

  def initialize( term, min_ex, max_ex, job_type, remote )
    @url = "https://stackoverflow.com/jobs/feed?"\
          "q=#{term}"\
          "&ms=#{min_ex}"\
          "&mxs=#{max_ex}"\
          "&j=#{job_type}"\
          "&l=United%20States&d=20&u=Miles" # Currently the application only supports US
    unless remote.nil?
      @url << "&r=true"
    end

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
          if item['location'].nil?
            city_loc = City.find_coordinates("remote", "us")
          else
            scs = City.split_city_state item["location"]
            city_loc = City.find_coordinates(scs[0],scs[1])
          end
          if city_loc.nil? then city_loc = City.find_coordinates("not found", "us") end

          categories = item['category'].presence || ["none"]
          categories = ( categories.is_a?(Array) ) ? categories : Array(categories)
          title = item['title'].split(" at ")
          remote = ""
          if title.last.include? "allows remote"
              title.first << " (allows remote)"
          end

          feature = { "type"           => "Feature",
                      "properties"     => {
                          "show_on_map"  => "true",
                          "link"         => item['link'],
                          "name"         => title.first,
                          "company"      => item['author']['name'],
                          "city"         => item['location'],
                          "category"     => categories,
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
