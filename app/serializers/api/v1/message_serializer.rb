class API::V1::MessageSerializer < API::V1::BaseSerializer
  attributes :id, :text, :created_at
  #has_one :user
end
