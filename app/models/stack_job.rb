class StackJob
  require 'active_support/core_ext/hash/conversions'
  require 'pp'

  def self.for( term, min_ex, max_ex, job_type )
    url = "http://stackoverflow.com/jobs/feed?"\
          "q=#{term}"\
          "&ms=#{min_ex}"\
          "&mxs=#{max_ex}"\
          "&j=#{job_type}"\
          "&l=United%20States&d=20&u=Miles" # Currently the application only supports US
    xml = Nokogiri::XML(open(url))
    hash = Hash.from_xml(xml.to_s)
    hash["rss"]["channel"]["item"]
  end
end
