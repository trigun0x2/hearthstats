class ImportController < ApplicationController
  def index

  end

  def constructed
    Match.import(params[:file], 3)
    redirect_to root_url, notice: "Constrcuted stats imported."
  end
end
