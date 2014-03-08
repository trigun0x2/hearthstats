class CoachesController < ApplicationController
  def index
    @coaches = Coach.where( active: true )
  end

  def show
    @coach = Coach.find(params[:id])
  end

  def new
   @coach = Coach.new
  end

  def create

  end
end
