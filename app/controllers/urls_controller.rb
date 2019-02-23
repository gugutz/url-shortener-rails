# frozen_string_literal: true

# Master class of the app
class UrlsController < ApplicationController
  require 'base62-rb'

  def index
    @urls = Url.all

    unless @urls.empty?
      @urls.each do |url|
        url.short_url = encode(url.id)
      end
    end

    if params[:original_url].present?
      Rails.logger.debug "URL: #{params[:original_url]}"
      create
    end
  end

  def show
    @url = Url.find(params[:id])
  end

  # def edit
  # end

  def valid_url?(url)
    if url =~ /\A\s*#{URI::regexp}\s*\z/
    # if url =~ URI::DEFAULT_PARSER.regexp(:ABS_URI)
      return true 
    else
      return false
    end
  end

  def create
    @url = Url.new(url_params)
    if valid_url?(@url.original_url)
      @url.hits = 0

      @url.save
      Rails.logger.info('saved URL in the database')
      redirect
    else
      Rails.logger.info 'Input is not a valid URL'
      redirect
    end
  end

  # def update
  # end

  # def destroy
  # end

  def redirect
    if params[:token].present?
      url_hash = params[:token]

      id = decode(url_hash)
      @url = Url.find(id)
      @url.hits = @url.hits + 1
      @url.save
      # redirect_to destination_url.original_url
      redirect_back(fallback_location: @url.original_url)
    else
      @msg = Rails.logger.info 'the :token parameter is empty'
      redirect_back(fallback_location: root_path)
    end
  end


  private

  def url_params
    params.require(:url).permit(:id, :original_url, :hits, :short_url)
  end

  def encode(id)
    id_hash = Base62.encode(id)
    # @url.short_url = ENV['APP_DOMAIN'] + id_hash
    short_url = 'https://hashfier.herokuapp.com/' + id_hash.to_s
    short_url
  end

  def decode(url_hash)
    id = Base62.decode(url_hash.to_s)

    if id.nil?
      Rails.logger.info 'id is null'
    else
      Rails.logger.info "id is #{id}"
      id
    end
  end

end

