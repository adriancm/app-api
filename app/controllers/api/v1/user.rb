module API
  module V1
    module UserParams
      extend Grape::API::Helpers

      params :user do
        requires :id, type: Integer, desc: 'User id'
      end

      params :pagination do
        optional :pagination, type: Hash do
          optional :page, type: Integer, desc: 'Page that you want [default: 1]'
          optional :per_page, type: Integer, desc: 'Number of elements by page [default: 25]' # config/initializers/kaminari_config.rb
        end
      end

    end
    class User < API::V1::Root
      include API::V1::Defaults
      helpers API::V1::UserParams
      #helpers DeviseController

      resource :users, desc: 'Operations about the current user' do

        desc "User's messages"
        oauth2
        params do
          use :user, :pagination
        end
        get '/messages' do
          messages = Message.where(user: params[:id]).order('created_at DESC')
          list = paginate_api(messages,params[:pagination])
          render ActiveModel::ArraySerializer.new(list,
                                                  each_serializer: API::V1::MessageSerializer,
                                                  root: 'messages',
                                                  current_user: current_user,
                                                  scope: self)
        end


        desc "User's followers"
        params do
          use :user, :pagination
        end
        oauth2
        get '/followers' do
          followers = User.find_by(id: params[:id]).followers_list rescue []
          list = paginate_api(followers,params[:pagination])
          render ActiveModel::ArraySerializer.new(list,
                                                  each_serializer: API::V1::UserSerializer,
                                                  root: 'followers',
                                                  current_user: current_user,
                                                  scope: self)
        end

        desc "User's followings"
        oauth2
        params do
          use :user, :pagination
        end
        get '/followings' do
          followings = User.find_by(id: params[:id]).followings rescue []
          list = paginate_api(followings,params[:pagination])
          render ActiveModel::ArraySerializer.new(list,
                                                  each_serializer: API::V1::UserSerializer,
                                                  root: 'followings',
                                                  current_user: current_user,
                                                  scope: self)
        end

      end

    end
  end
end