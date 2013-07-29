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
      last_response.should match /You will need to log in to your Twitter account.*Log in via Twitter/
    end
  end

  describe 'GET /login/twitter' do
    before do
      get '/login/twitter'
    end

    it 'should redirect' do
      last_response.should be_redirect
    end
  end

  describe 'GET /login/complete with credentials' do
    before do
      get '/login/complete', { oauth_verifier: 'fake' }, { 'rack.session' => { token: 'fake', secret: 'fake' } }
    end

    it 'should redirect to main app on success' do
      last_response.should be_redirect
      follow_redirect!
      last_request.url.should == 'http://example.org/'
    end
  end
end