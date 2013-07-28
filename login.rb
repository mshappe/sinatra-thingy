require 'sinatra/base'
require 'slim'

class Login < Sinatra::Base
  enable :sessions

  get '/login' do
    slim :login, layout: :app_layout
  end
end