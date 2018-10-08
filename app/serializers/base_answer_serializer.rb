class BaseAnswerSerializer < BaseAnswerAttrSerializer
  belons_to :user, key: :author, serializer: AuthorSerializer
end
