class UserDecorator < Draper::Decorator
  delegate_all
  decorates_associations :questions, context: { id: :id, title: :title, rating: :rating }
  decorates_associations :answers, context: { id: :id, body: :body, rating: :rating }

  def name
    [first_name, last_name].join(' ')
  end

  def answered_questions
    answers_arr = answers
    ans_question = []
    answers_arr.each { |a| ans_question << a.question }
    ans_question
  end

  def params
    {
      id: object.id,
      email: object.email,
      first_name: object.first_name,
      last_name: object.last_name,
      reputation: object.reputation,
      name: name,
      self_questions: questions,
      self_answers: answers,
      questions_count: object.questions.count,
      answers_count: object.answers.count,
      answered_questions: answered_questions
    }
  end

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end
end
