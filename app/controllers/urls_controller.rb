class UrlsController < ApplicationController
  require 'base62-rb'

  def index
    @urls = Url.all
  end
  

  def show
    @url = Url.find(params[:id])
  end


  def new
  end
    

  def edit
  end


  def create
    @url = Url.new(url_params)
    @url.hits = 0

    @url.save
    redirect_back(fallback_location: root_path)
    # redirect_to @url
  end

  
  def update
  end
  
  def destroy
  end

  private
  def url_params
    params.require(:url).permit(:id, :original_url, :hits)
  end
  

end








