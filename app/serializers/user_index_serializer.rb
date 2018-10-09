class UserIndexSerializer < BaseUserSerializer
  attributes :question_count, :answer_count

  def question_count
    object.questions.count
  end

  def answer_count
    object.answers.count
  end
end
