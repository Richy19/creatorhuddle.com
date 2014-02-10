class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :receiver_id, :sender_id, :target_id, :target_type
end
