class StackJob
  attr_accessor :url, :xml, :geojson

  require 'active_support/core_ext/hash/conversions'
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
      json = '{ "type": "FeatureCollection","features" : ['
      items.each do | item |
          json << '{"type": "Feature",'
          json << '"properties": {'
          json << '"show_on_map" : true,'
          json << '"name" : "' << item['title'] << '",'
          json << '"link" : "' << item['link'] << '",'
          json << '"company" : "' << item['author']['name'] << '",'
          json << '"city" : "' << item['location'] << '",'
          json << '"category": ["test"],'
          json << '"date" : "' << item['pubDate'] << '"'

          scs = City.split_city_state item["location"]
          city_loc = City.find_coordinates(scs[0],scs[1])
          if city_loc.nil? then city_loc = City.find_coordinates("not found", "us") end

          json << '}, "geometry": {"type": "Point",'
          json << '"coordinates": [' << city_loc.long.to_s << ',' << city_loc.lat.to_s << ']'
          json << '}},'
      end
      json = json[0...-1]
      json << ']}'
      @geojson = json
      @geojson
  end
end
