class PlayController < ApplicationController
  def index
  	require 'json'
  	@course = Course.find_by_id(params[:id])
  end
end
