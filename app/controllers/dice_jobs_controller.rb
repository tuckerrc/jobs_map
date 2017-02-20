class DiceJobsController < ApplicationController
  def index
    @search_term = ''
    @dice_jobs = DiceJob.for(@search_term)
  end
end
