require 'oauth'

module TwitterAccess
  def get_initial_request_token
    request_token    = oauth.get_request_token oauth_callback: 'http://localhost:4567/login/complete'
    session[:token]  = request_token.token
    session[:secret] = request_token.secret
    request_token
  end

  def get_access_token(verify=false)
    session[:oauth_verifier] = params[:oauth_verifier] if params[:oauth_verifier]
    request_token = OAuth::RequestToken.new oauth, session[:token], session[:secret]
    access_token  = request_token.get_access_token oauth_verifier: session[:oauth_verifier]
    oauth.request :get, '/1.1/account/verify_credentials.json', access_token, scheme: :query_string if verify

    access_token
  end

  def oauth
    @oauth ||= OAuth::Consumer.new 'RoF7OV63qIPpxMvAfIAvA', 'SopfN1Pez0dRobFc1tdYDyhT8t4VTDL3KLdOdVgzU', { site: 'https://api.twitter.com/', scheme: :header }
  end
end