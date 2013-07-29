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
    p params[:location]
    response = oauth.request :get, "/1.1/search/tweets.json?q=#{CGI::escape params[:q]}&geocode=#{params[:location][:coords][:latitude]},#{params[:location][:coords][:longitude]},50mi", session[:auth_token], scheme: :header

    p response.body
    @result = Yajl::Parser.parse response.body unless response.body == []
    slim :search_partial, layout: false
  end
end
