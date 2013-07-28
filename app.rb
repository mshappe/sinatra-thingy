require 'sinatra/base'
require './login'

class Thingy < Sinatra::Base
  use Login

  before do
    unless session['auth_token']
      redirect :login
    end
  end

  get '/' do
    slim :index, layout: :app_layout
  end
end
