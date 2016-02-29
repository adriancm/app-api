class API::V1::BaseSerializer < ActiveModel::Serializer
  include Api::V1::BaseApiHelper
  def created_at
    object.created_at.in_time_zone.iso8601 if defined?(object.created_at)
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if defined?(object.updated_at)
  end

end