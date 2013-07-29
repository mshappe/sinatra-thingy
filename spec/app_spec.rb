require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'spec_helper'

describe "Sinatra Thingy" do
  def app
    Thingy
  end

  describe 'GET / with no session' do
    before do
      get '/'
    end

    it 'should return Redirect' do
      last_response.should be_redirect
    end
  end

  describe 'GET / with session' do
    before do
      get '/', {}, { 'rack.session' => { 'auth_token' => 'Foo' }}
    end

    it 'should return OK and a body' do
      last_response.should be_ok
      last_response.should match /<form/
    end
  end


end