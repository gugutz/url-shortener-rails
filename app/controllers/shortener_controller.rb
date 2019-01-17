class ShortenerController < ApplicationController
  def index
    shorten(link)
  end

  def shorten(link)
    short_url = ShortUrl.new
    short_url = link

  end
  
      
end

