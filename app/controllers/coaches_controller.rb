class CoachesController < ApplicationController
  def index
    @coaches = Coach.where( active: true )
  end

  def new
   @coach = Coach.new
  end

  def create

  end
end
