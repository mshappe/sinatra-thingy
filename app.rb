require 'sinatra/base'
require 'yajl'
require './login'


class Thingy < Sinatra::Base
  include TwitterAccess
  use Login

  before do
    redirect :login unless access_token
  end

  get '/' do
    slim :index, layout: :app_layout
  end

  post '/search' do
    begin
      response = access_token.get query_string
      @result = Yajl::Parser.parse response.body unless response.body == []
      slim :search_partial, layout: false
    rescue => e
      @error = e.to_s
      slim :search_error, layout: false
    end
  end

  protected

  def geocode_params
    "&geocode=#{params[:location][:latitude]},#{params[:location][:longitude]},50mi" if location_present?
  end
  
  def location_present?
    params[:location] && params[:location].is_a?(Hash)
  end

  def query_string
    "/1.1/search/tweets.json?q=#{CGI::escape params[:q]}&count=100#{geocode_params}"
  end
end
