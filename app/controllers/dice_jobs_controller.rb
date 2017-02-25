class DiceJobsController < ApplicationController
  def index
    @search_term = 'ruby on rails'
    @dice_jobs = DiceJob.for(@search_term)
  end
end
