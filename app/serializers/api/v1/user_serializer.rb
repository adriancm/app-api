class API::V1::UserSerializer < API::V1::BaseSerializer
  attributes :first_name, :last_name, :email, :username
end
