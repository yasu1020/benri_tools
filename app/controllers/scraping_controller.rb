class ScrapingController < ApplicationController

  def index
    @site =Site.new
  end

  def show

    #URL
    @url = params[:site][:url]

    #構成の抽出
    @details = Site.test(params[:site][:url])

    #タイトルの抽出
    @title = Site.title(params[:site][:url])

  end
end
