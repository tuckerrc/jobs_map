class StackJob
  require 'active_support/core_ext/hash/conversions'
  require 'pp'

  def self.for term
    url = "http://stackoverflow.com/jobs/feed?q=#{term}&l=United%20States&d=20&u=Miles"
    xml = Nokogiri::XML(open(url))
    hash = Hash.from_xml(xml.to_s)
    hash["rss"]["channel"]["item"]
  end
end
