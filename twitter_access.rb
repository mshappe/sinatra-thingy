require 'oauth'

module TwitterAccess
  def initial_request_token
    request_token        = oauth.get_request_token oauth_callback: 'http://localhost:4567/login/complete'
    session[:req_token]  = request_token.token
    session[:req_secret] = request_token.secret
    request_token
  end

  def initial_access_token(verify=false)
    request_token = OAuth::RequestToken.new oauth, session[:req_token], session[:req_secret]
    access_token  = request_token.get_access_token oauth_verifier: params[:oauth_verifier]
    oauth.request :get, '/1.1/account/verify_credentials.json', access_token, scheme: :query_string if verify

    session[:access_token]  = access_token.token
    session[:access_secret] = access_token.secret
    access_token
  end

  def access_token
    @access ||= OAuth::AccessToken.new oauth, session[:access_token], session[:access_secret] unless session[:access_token].nil?
  end

  def oauth
    @oauth ||= OAuth::Consumer.new 'RoF7OV63qIPpxMvAfIAvA', 'SopfN1Pez0dRobFc1tdYDyhT8t4VTDL3KLdOdVgzU', { site: 'https://api.twitter.com/', scheme: :header }
  end
end
