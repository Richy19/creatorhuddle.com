class FollowSerializer < ActiveModel::Serializer
  attributes :id, :followable_id, :followable_type, :user_id
end
