require 'spec_helper'

describe 'Users API V1', type: :request do
  describe 'messages' do
    it 'Sends correct error code when no user present' do
      get '/api/user/1/messages', format: :json
      expect(response.response_code).to eq(401)
      expect(response.body.match('OAuth')).to be_present
      expect(response.headers['Content-Type'].match('json')).to be_present
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end
    
    it 'fails if no access token' do
      get '/api/user/1/messages', format: :json
      expect(response.response_code).to eq(401)
      expect(JSON(response.body)['error'].present?).to be_truthy
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end

    it 'responds with the empty array of messages' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      get '/api/user/0/messages', format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['messages']).to eq([])
      expect(response.response_code).to eq(200)
    end

    it 'responds with the messages' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      get "/api/user/#{@user.id}/messages", format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['messages'][0]['id']).to eq(@user.messages.first.id)
      expect(result['messages'][0]['text']).to eq(@user.messages.first.text)
      expect(response.response_code).to eq(200)
    end
  end


  describe 'followers' do

    it 'Sends correct error code when no user present' do
      get '/api/user/1/followers', format: :json
      expect(response.response_code).to eq(401)
      expect(response.body.match('OAuth')).to be_present
      expect(response.headers['Content-Type'].match('json')).to be_present
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end

    it 'fails if no access token' do
      get '/api/user/1/followers', format: :json
      expect(response.response_code).to eq(401)
      expect(JSON(response.body)['error'].present?).to be_truthy
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end

    it 'responds with the empty array of messages' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      get '/api/user/0/followers', format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['followers']).to eq([])
      expect(response.response_code).to eq(200)
    end

    it 'responds with the messages' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      create_n_users 1
      @user.inverse_follows.build(followed_id: @users.first.id).save
      get "/api/user/#{@user.id}/followers", format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['followers'][0]['first_name']).to eq(@users.first.first_name)
      expect(result['followers'][0]['last_name']).to eq(@users.first.last_name)
      expect(result['followers'][0]['email']).to eq(@users.first.email)
      expect(result['followers'][0]['username']).to eq(@users.first.username)
      expect(response.response_code).to eq(200)
    end
  end


  describe 'followings' do
    it 'Sends correct error code when no user present' do
      get '/api/user/1/followings', format: :json
      expect(response.response_code).to eq(401)
      expect(response.body.match('OAuth')).to be_present
      expect(response.headers['Content-Type'].match('json')).to be_present
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end

    it 'fails if no access token' do
      get '/api/user/1/followings', format: :json
      expect(response.response_code).to eq(401)
      expect(JSON(response.body)['error'].present?).to be_truthy
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end

    it 'responds with the empty array of messages' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      get '/api/user/0/followings', format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['followings']).to eq([])
      expect(response.response_code).to eq(200)
    end

    it 'responds with the messages' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      create_n_users 1
      @users.first.follows.build(follower_id: @user.id).save
      get "/api/user/#{@users.first.id}/followings", format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['followings'][0]['first_name']).to eq(@user.first_name)
      expect(result['followings'][0]['last_name']).to eq(@user.last_name)
      expect(result['followings'][0]['email']).to eq(@user.email)
      expect(result['followings'][0]['username']).to eq(@user.username)
      expect(response.response_code).to eq(200)
    end
  end
end