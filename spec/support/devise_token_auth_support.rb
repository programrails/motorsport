module DeviseTokenAuthSupport
  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
                    'client' => client,
                    'uid' => uid,
                    'expiry' => expiry,
                    'token_type' => token_type
    }
    auth_params
  end

  def login(user)
    post api_v1_user_session_path, params: { email: user.email, password: user.password }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    get_auth_params_from_login_response_headers response
  end
end
