class UrlsController < ApplicationController

  def index
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

    @url.save
    redirect_to @url

    # render plain: params[:url].inspect
  end

  
  def update
  end
  
  def destroy
  end

  private
  def url_params
    params.require(:url).permit(:id, :original_url)
  end
  

end








