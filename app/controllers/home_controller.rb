# controller used for front page of the app
class HomeController < ApplicationController

  def index
    @urls = Url.all
    url = UrlsController.new

    @url = Url.new

    if params[:original_url].present?
      Rails.logger.debug "URL: #{params[:original_url]}"
      UrlsController.create
    end
  end

  def signup
  end

  def login
  end

end
