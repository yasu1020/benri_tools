class GoogleController < ApplicationController

  def index
    @keyword =Google.new
  end

  def show
    @results = Google.google_result(params[:google][:keyword])
  end

end
