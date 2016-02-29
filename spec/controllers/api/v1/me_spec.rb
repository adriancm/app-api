require 'spec_helper'

describe 'Me API V1', type: :request do
  describe 'current' do
    it 'Sends correct error code when no user present' do
      get '/apime'
      expect(response.response_code).to eq(401)
      expect(response.body.match('OAuth')).to be_present
      expect(response.headers['Content-Type'].match('json')).to be_present
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end
    
    it 'fails if no access token' do
      get '/api/me', format: :json
      expect(response.response_code).to eq(401)
      expect(JSON(response.body)['error'].present?).to be_truthy
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(response.headers['Access-Control-Request-Method']).to eq('*')
    end

    it 'responds with the user' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      get '/api/me', format: :json, access_token: @token.token
      result = JSON.parse(response.body)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
      expect(result['user']['username']).to eq(@user.username)
      expect(result['user']['email']).to eq(@user.email)
      expect(response.response_code).to eq(200)
    end
  end

  describe 'messages' do
    it 'gets messages, returning correct pagination serialized by the serializer' do
      create_doorkeeper_app(scopes: OAUTH_SCOPES_S)
      get '/api/me/messages', format: :json, access_token: @token.token
      result = JSON.parse(response.body)

      expect(result['me'][0].keys.include?('secret')).to_not be_present
      expect(response.code).to eq('200')
      expect(response.header['Total']).to eq('20')
      expect(response.header['Link'].match('page=2>; rel=\"next\"')).to be_present
    end
  end

  describe 'update current user' do 
    context 'incorrectly scoped access token' do
      it "fails if the access token doesn't have the required scope" do
        create_doorkeeper_app(scopes: 'read_user')
        username = @user.username
        attributes = {email: 'foo@bar.com', username: 'new namething', access_token: @token.token}
        put '/api/me', attributes, format: :json

        expect(response.response_code).to eq(403)
        expect(response.body.match(/OAuth error.* write to user/i)).to be_present
        @user.reload
        expect(@user.username).to eq(username)
      end
    end
    context 'scoped access token' do
      it 'updates the user' do
        create_doorkeeper_app(scopes: 'write_user')
        attributes = {email: 'foo@bar.com', username: 'new username', access_token: @token.token}
        put '/api/me', attributes, format: :json
        @user.reload

        expect(response.response_code).to eq(200)
        expect(@user.username).to eq('new username')
        expect(@user.unconfirmed_email).to eq('foo@bar.com')
      end
    end
  end
end