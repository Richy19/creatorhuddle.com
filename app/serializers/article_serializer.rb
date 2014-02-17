class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :content, :user_id
end
