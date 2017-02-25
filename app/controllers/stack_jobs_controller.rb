class StackJobsController < ApplicationController
  def index
    @search_term = params[:search] || 'ruby on rails'
    @stack_jobs = StackJob.for @search_term
  end
end
