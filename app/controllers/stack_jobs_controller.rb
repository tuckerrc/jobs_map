class StackJobsController < ApplicationController
  def index
    @search_term
    @stack_jobs = StackJob.for(@seach_term)
  end
end
