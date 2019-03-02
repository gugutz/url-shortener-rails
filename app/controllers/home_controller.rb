# controller used for front page of the app
class HomeController < ApplicationController

  def index
    @urls = Url.all
    url = UrlsController.new

    unless @urls.empty?
      @urls.each do |link|
        link.short_url = url.encode(link.id)
      end
    end

    if params[:original_url].present?
      Rails.logger.debug "URL: #{params[:original_url]}"
      UrlsController.create
    end
  end

end
