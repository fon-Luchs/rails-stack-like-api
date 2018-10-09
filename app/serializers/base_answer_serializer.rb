class BaseAnswerSerializer < BaseAnswerAttrSerializer
  belongs_to :user, key: :author, serializer: AuthorSerializer
end
