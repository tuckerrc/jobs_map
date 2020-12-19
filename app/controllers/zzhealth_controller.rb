class ZzhealthController < ApplicationController

  def index
    data = {
      'status' => 200,
      'message' => 'OK',
      'data' => [],
    }
    render :json => data
  end
end
