require 'multi_json'
require 'sinatra/base'
require 'yajl'
require 'sinatra/json'
require './login'


class Thingy < Sinatra::Base
  helpers Sinatra::JSON
  include TwitterAccess
  use Login

  before do
    unless session['auth_token']
      redirect :login
    end
  end

  get '/' do
    slim :index, layout: :app_layout
  end

  post '/search.json' do
    query_string = "/1.1/search/tweets.json?q=#{CGI::escape params[:q]}&count=100"
    query_string += "&geocode=#{params[:location][:coords][:latitude]},#{params[:location][:coords][:longitude]},50mi" if params[:location] && params[:location].is_a?(Hash)
    response = oauth.request :get, query_string, session[:auth_token], scheme: :header

    @result = Yajl::Parser.parse response.body unless response.body == []
    slim :search_partial, layout: false
  end
end
