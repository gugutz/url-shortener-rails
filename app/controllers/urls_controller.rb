# frozen_string_literal: true

# Master class of the app
class UrlsController < ApplicationController
  require 'base62-rb'

  def show
    @url = Url.find(params[:id])
  end

  # def edit
  # end

  def create
    @url = Url.create(original_url: url_params[:original_url])
    Rails.logger.info('saved URL in the database')
    redirect
  end

  # def update
  # end

  # def destroy
  # end


  def redirect
    if params[:token].present?
      url_hash = params[:token]

      @url = Url.find_by_hash(url_hash)
      @url.hit
      redirect_back(fallback_location: @url.original_url)
    else
      @msg = Rails.logger.info 'the :token parameter is empty'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def all_params
    params.require(:url).permit(:id, :original_url, :hits)
  end

  def url_params
    params.require(:url).permit(:original_url, :hits)
  end

  def redirect_params
    params.require(:token)
  end

end

