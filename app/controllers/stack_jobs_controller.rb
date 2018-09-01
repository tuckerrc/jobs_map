class StackJobsController < ApplicationController
  def index
    @search_term = params[:search] || '[ruby-on-rails]'
    @min_experience = params[:min] || ''
    @max_experience = params[:max] || ''
    @job_type = params[:type] || ''
    @remote = params[:remote] || nil

    @stack_jobs = StackJob.new( @search_term, @min_experience, @max_experience, @job_type, @remote )
  end
end
