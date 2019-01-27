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
    @url.hits = 0

    # @url.id is only accessible after saving in the database
    @url.save


    redirect_back(fallback_location: root_path)
    # redirect_to @url
  end

  
  def update
  end
  
  def destroy
  end

  
  def redirect
    if params[:token].empty? 
      @teste = "esta vazio"
    else
      @teste = "nao esta vazio"
    # short_url = request.referer # this catch the incoming url, including its params
    # url_hash = URI(short_url).query # this returns an string with the incoming url params
    # url_hash = short_url[32..-1]
      url_hash =  params[:token]
      decode(url_hash)
    end
  end
  
      
  def decode(url_hash)
    id = Base62.decode(url_hash.to_s)

    if id.nil?
      logger.info "id is null"
    else
      logger.info "id is #{id}"
      destination_url = Url.find(id)
      # redirect_to destination_url.original_url
      redirect_back(fallback_location: destination_url.original_url)
    end

  end

  private
  def url_params
    params.require(:url).permit(:id, :original_url, :hits, :short_url)
  end

  def get_url_hash(short_url)
  end

  def encode(id)
    id_hash = Base62.encode(id)
    # @url.short_url = ENV['APP_DOMAIN'] + id_hash
    short_url = "https://hashfier.herokuapp.com/" + id_hash.to_s
  end
  
  

end








