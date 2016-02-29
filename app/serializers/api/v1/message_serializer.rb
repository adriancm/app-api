class API::V1::MessageSerializer < API::V1::BaseSerializer
  attributes :id, :text
  has_one :user
end
