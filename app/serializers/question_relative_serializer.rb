class QuestionRelativeSerializer < BaseQuestionAttrSerializer
  attributes :body, :rating, :answers

  belongs_to :user, key: :author, serializer: AuthorSerializer
  has_many :answers, serialize: BaseAnswerSerializer
end
