class UserSerializer < UserBaseSerializer
  attributes :reputation, :name, :question_count, :answers_count

  def name
    { name: object.first_name + ' ' + object.last_name }
  end

  def question_count
    { question_count: object.questions.count }
  end

  def answers_count
    { answers_count: object.answers.count }
  end
end
