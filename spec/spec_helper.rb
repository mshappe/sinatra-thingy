require 'fakeweb'
require 'rack/test'
require 'rspec'
require 'sinatra'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

# Stole this strategy from http://blog.zerosum.org/2009/7/13/twitter-auth-integration-testing
FakeWeb.allow_net_connect = false
FakeWeb.register_uri :post, 'https://api.twitter.com/oauth/request_token', body: 'oauth_token=fake&oauth_token_secret=fake'
FakeWeb.register_uri :post, 'https://api.twitter.com/oauth/access_token', body: 'oauth_token=fake&oauth_token_secret=fake'
FakeWeb.register_uri :get, %r[^https://api\.twitter\.com/1\.1/account/verify_credentials\.json?], body: ''

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end