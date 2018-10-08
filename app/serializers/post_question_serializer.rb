class PostQuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :rating
end
