class QuestionRelativeSerializer < BaseQuestionAttrSerializer
  attributes :body, :rate, :author, :answers

  belongs_to :user, key: :author, serializer: AuthorSerializer
  has_many :answers, serialize: BaseAnswerSerializer
end
