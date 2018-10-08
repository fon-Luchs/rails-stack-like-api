class ProfileSerializer < BaseUserAttrSerializer
  attributes :first_name, :last_name, :reputation

  has_many :questions, key: :self_questions, serializer: BaseQuestionSerializer
  has_many :answers, key: :self_answers, serializer: BaseAnswerAttrSerializer
end
