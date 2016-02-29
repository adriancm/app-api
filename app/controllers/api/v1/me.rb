module API
  module V1
    class Me < API::V1::Root
      include API::V1::Defaults

      resource :me, desc: "Operations about the current user" do
        
        desc "Current user's information in access token's scope<span class='accstr'>*</span>", {
          notes: <<-NOTE
            Current user is the owner of the `access_token` you use in the request.
          NOTE
        }
        oauth2
        get '/' do
          render API::V1::UserSerializer.new current_user
        end

        paginate per_page: 10 # This paginates, with a default of 10 per page
        oauth2
        get '/messages', each_serializer: API::V1::MessageSerializer do
          # create some imaginary items
          items = (0..19).map{ |i|
            Message.new(user: current_user, text: "Foo #{i*7}")
          }
          # We use the item serializer to serialize these items!
          paginate items
        end

        desc 'Update user, Protected, only accessible with write user'
        params do
          optional :email, type: String, desc: 'User email'
          optional :username, type: String, desc: 'User username'
        end
        oauth2 'write_user'
        put '/' do
          # By using declared params, we ensure we only use the whitelisted params
          # and ignore missing params (not setting their values to nil)
          declared_p = declared(params, include_missing: false)

          current_user.update_attributes(declared_p)
          render API::V1::UserSerializer.new current_user
        end
      end

    end
  end
end