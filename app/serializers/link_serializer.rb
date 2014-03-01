class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url, :name, :score
end
