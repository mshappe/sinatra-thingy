require File.join(File.dirname(__FILE__), '..', 'login.rb')
require 'spec_helper'

describe 'Login' do
  def app
    Login
  end

  describe 'GET /login' do
    before do
      get '/login'
    end

    it 'should return a login page' do
      last_response.should be_ok
      last_response.should match /You will need to log in to your Twitter account/
    end
  end

end