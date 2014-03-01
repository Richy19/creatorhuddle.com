class RatingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :positive, :ratable_id, :ratable_type
end
