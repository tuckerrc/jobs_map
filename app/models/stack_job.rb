class StackJob < ApplicationRecord

  def to_geojson
      hash = Hash.from_xml(self.xml)
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

          date = DateTime.parse(item['pubDate'])
          dateFmt = date.strftime("%Y-%m-%dT%H:%M:%S")
          categories = item['category'].presence || ["none"]
          categories = ( categories.is_a?(Array) ) ? categories : Array(categories)
          title = item['title'].split(" at ")
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
                          "date"         => dateFmt
                         },
                      "geometry"       => {
                          "type"         => "Point",
                          "coordinates"  => [ city_loc.long, city_loc.lat ]
                         }
                    }
          features.push( feature )

      end
      json["features"] = features
      self.geo_json = json.to_json
      self.save
      self.geo_json
  end
end
