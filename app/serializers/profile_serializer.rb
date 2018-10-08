class ProfileSerializer < UserBaseSerializer
  attributes :first_name, :last_name

  has_many :questions, key: :self_question
  has_many :answers, key: :self_answer
end
