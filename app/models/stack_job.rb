class StackJob
  attr_accessor :url, :xml, :geojson

  require 'active_support/core_ext/hash/conversions'
  require 'pp'

  def initialize( term, min_ex, max_ex, job_type )
    @url = "https://stackoverflow.com/jobs/feed?"\
          "q=#{term}"\
          "&ms=#{min_ex}"\
          "&mxs=#{max_ex}"\
          "&j=#{job_type}"\
          "&l=United%20States&d=20&u=Miles" # Currently the application only supports US
    @xml = Nokogiri::XML(open(url))
    self.to_geojson
    @geojson
  end

  def to_geojson
      hash = Hash.from_xml(@xml.to_s)
      items = hash['rss']['channel']['item']
      json = '{ "type": "FeatureCollection","features" : ['
      items.each do | item |
          json << '{"type": "Feature", "properties": {'
          json << '"show_on_map" : true,'
          json << '"name" : "' << item['title'] << '",'
          json << '"link" : "' << item['link'] << '",'
          json << '"company" : "' << item['author']['name'] << '",'
          json << '"city" : "' << item['location'] << '",'
          json << '"date" : "' << item['pubDate'] << '",'

          json << '},'
      end
      json = json[0...-1]
      json << ']}'
      @geojson = json
      puts @geojson
  end
end
