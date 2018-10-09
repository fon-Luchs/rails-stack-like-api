class QuestionRelativeSerializer < BaseQuestionAttrSerializer
  attributes :body, :rate, :author, :answers

  belons_to :user, key: :author, serializer: AuthorSerializer
  has_many :answers, serialize: BaseAnswerSerializer
end
