class ImportController < ApplicationController
  require 'csv'
  def index

  end

  def constructed
    Match.import(params[:file], 3, current_user.id)
    redirect_to root_url, notice: "Constrcuted stats imported."
  end
end
