# controller used for front page of the app
class HomeController < ApplicationController

  def index
    @urls = Url.all
    url = UrlsController.new

    unless @urls.empty?
      @urls.each do |link|
        id_hash = url.encode(link.id)
        link.short_url = url.mount_short_url(id_hash)
      end
    end

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
