class UpdateSerializer < ActiveModel::Serializer
  attributes :id, :updateable_id, :updateable_type, :content, :user_id
end
