class UrlsController < ApplicationController

  def create
    @url = Url.new(url_params)

    @url.save
    redirect_to @url
    # render plain: params[:url].inspect
  end

  private
  def url_params
    params.require(:url).permit(:original_url, :hash)
  end
  

end








