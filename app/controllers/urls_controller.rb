class UrlsController < ApplicationController
  require 'base62-rb'

  def index
    @urls = Url.all

    if @urls.empty?
      
    else
      @urls.each do |url|
        url.short_url = encode(url.id)
      end
    end

    @urls
  end

  def show
    @url = Url.find(params[:id])
  end

  def edit
  end

  def create
    @url = Url.new(url_params)
    if @url.original_url =~ URI::regexp
      @url.hits = 0

      # @url.id is only accessible after saving in the database
      @url.save

      redirect_back(fallback_location: root_path)
      @url
    else
      msg = "the URL provided is not a valid URI" 
      Rails.logger.debug(msg)
      
      redirect_back(fallback_location: root_path)

      msg
    end
  end

  def update
  end
  
  def destroy
  end
  
  def redirect
    if params[:token].empty? 
      @msg = throw "the :token parameter is empty"
    else
      url_hash =  params[:token]

      id = decode(url_hash)
      @url = Url.find(id)
      @url.hits = @url.hits + 1
      @url.save

      # redirect_to destination_url.original_url
      redirect_back(fallback_location: @url.original_url)
    end
  end
  
  


  private
  def url_params
    params.require(:url).permit(:id, :original_url, :hits, :short_url)
  end

  def encode(id)
    id_hash = Base62.encode(id)
    # @url.short_url = ENV['APP_DOMAIN'] + id_hash
    short_url = "https://hashfier.herokuapp.com/" + id_hash.to_s
  end
  
  def decode(url_hash)
    id = Base62.decode(url_hash.to_s)

    if id.nil?
      logger.info "id is null"
    else
      logger.info "id is #{id}"
      id
    end

  end

  
  

end








