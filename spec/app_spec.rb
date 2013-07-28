require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'spec_helper'

describe "Sinatra Thingy" do
  def app
    Thingy
  end

  describe 'GET /' do
    before do
      get '/'
    end

    it 'should return OK and an expected body' do
      last_response.should be_ok
      last_response.should
    end

  end
end