require 'sinatra/base'
require 'slim'
require 'oauth'
require './twitter_access'

class Login < Sinatra::Base
  include TwitterAccess

  enable :sessions

  get '/login' do
    slim :login, layout: :app_layout
  end

  get '/login/twitter' do
    redirect get_initial_request_token.authorize_url
  end

  get '/login/complete' do
    begin
      session[:auth_token] = get_access_token # will throw exceptions on failure
      session[:notice] = 'Successfully logged in via Twitter'
      session[:error] = nil

      redirect '/'
    rescue => e
      puts e
      session[:error] = 'Failed to log in via Twitter'
      session[:notice] = nil
      redirect '/login'
    end
  end
end