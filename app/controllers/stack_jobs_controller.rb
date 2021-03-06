class StackJobsController < ApplicationController

  require 'open-uri'
  require 'digest'

  def index
    @search_term = params[:search] || '[ruby-on-rails]'
    @min_experience = params[:min] || ''
    @max_experience = params[:max] || ''
    @job_type = params[:type] || ''
    @remote = params[:remote] || nil

    args = {
      :search =>  @search_term,
      :min_experience => @min_experience,
      :max_experience => @max_experience,
      :job_type => @job_type,
      :remote => @remote
    }

    url = stack_jobs_url(args)

    @stack_jobs = get_stack_jobs(url)
  end

  def search
    args = {
      :search =>  params[:search] || '[ruby-on-rails]',
      :min_experience => params[:min] || '',
      :max_experience => params[:max] || '',
      :job_type => params[:type] || '',
      :remote => params[:remote] || nil
    }

    url = stack_jobs_url(args)

    begin
      @stack_jobs = get_stack_jobs(url)
      if (@stack_jobs.geo_json.blank?)
        render json: {"type": "Error", "message": "No jobs found. Try another search"}
      else
        render json: @stack_jobs.geo_json
      end
    rescue NoMethodError
      render json: {"type": "Error", "message": "No jobs found. Try another search"}
    end

  end

  private
    def get_stack_jobs(url)
      url_md5 = Digest::MD5.hexdigest url

      @stack_jobs = StackJob.find_by(md5hash: url_md5)
      if @stack_jobs.blank?
        xml = Nokogiri::XML(open(url))
        @stack_jobs = StackJob.create(
          md5hash: url_md5,
          xml: xml,
          url: url
        )
        @stack_jobs.geo_json = @stack_jobs.to_geojson
        @stack_jobs.save
      elsif @stack_jobs.updated_at < (Time.now - 60.minutes)
        xml = Nokogiri::XML(open(url))
        @stack_jobs.xml = xml
        @stack_jobs.geo_json = @stack_jobs.to_geojson
        @stack_jobs.save
      end
      @stack_jobs
    end

    def stack_jobs_url(**args)
      url = "https://stackoverflow.com/jobs/feed?"\
            "q=#{args[:search]}"\
            "&ms=#{args[:min_experience]}"\
            "&mxs=#{args[:max_experience]}"\
            "&j=#{args[:job_type]}"\
            "&l=United%20States&d=20&u=Miles" # Currently the application only supports US
      unless args[:remote].nil?
        url << "&r=true"
      end
      url
    end

end
