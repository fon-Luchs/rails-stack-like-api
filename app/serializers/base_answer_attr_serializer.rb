class BaseAnswerAttrSerializer < ActiveModel::Serializer
  attributes :id, :body, :rating
end
