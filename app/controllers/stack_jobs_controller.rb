class StackJobsController < ApplicationController
  def index
    @search_term = params[:search] || '[gis]'
    @min_experience = params[:min] || ''
    @max_experience = params[:max] || ''
    @job_type = params[:type] || ''

    @stack_jobs = StackJob.new( @search_term, @min_experience, @max_experience, @job_type )
  end
end
