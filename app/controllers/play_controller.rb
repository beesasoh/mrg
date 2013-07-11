class PlayController < ApplicationController
  def index
  	@course = Course.find_by_id(params[:id])
  end
end
