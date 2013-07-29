require 'sinatra/base'
require 'sinatra/json'
require 'yajl'
require './login'


class Thingy < Sinatra::Base
  helpers Sinatra::JSON
  include TwitterAccess
  use Login

  before do
    unless session[:auth_token]
      redirect :login
    end
  end

  get '/' do
    slim :index, layout: :app_layout
  end

  post '/search.json' do
    query_string = "/1.1/search/tweets.json?q=#{CGI::escape params[:q]}&count=100"
    query_string += "&geocode=#{params[:location][:coords][:latitude]},#{params[:location][:coords][:longitude]},50mi" if params[:location] && params[:location].is_a?(Hash)

    begin
      response = get_access_token.get query_string
      @result = Yajl::Parser.parse response.body unless response.body == []
      slim :search_partial, layout: false
    rescue => e
      puts e
      @error = e.to_s
      slim :search_error, layout: false
    end
  end
end
