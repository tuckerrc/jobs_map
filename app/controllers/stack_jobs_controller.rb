class StackJobsController < ApplicationController
  require 'open-uri'
  def index
    @search_term = params[:search] || '[ruby-on-rails]'
    @min_experience = params[:min] || ''
    @max_experience = params[:max] || ''
    @job_type = params[:type] || ''
    @remote = params[:remote] || nil

    url = "https://stackoverflow.com/jobs/feed?"\
          "q=#{@search_term}"\
          "&ms=#{@min_experience}"\
          "&mxs=#{@max_experience}"\
          "&j=#{@job_type}"\
          "&l=United%20States&d=20&u=Miles" # Currently the application only supports US
    unless @remote.nil?
      url << "&r=true"
    end

    xml = Nokogiri::XML(open(url))
    @stack_jobs = StackJob.new(url, xml)
  end
end
