class UserDecorator < Draper::Decorator
  delegate_all
  decorates_associations :questions, context: { id: :id, title: :title, rating: :rating }

  def name
    [first_name, last_name].join(' ')
  end

  def self_questions
    questions
  end

  def self_answers
    []
  end

  def answered_questions
    [
      {
        id: 321,
        title: 'What\'s going on?',
        reputation: 347
      }
    ]
  end

  def params
    {
      id: object.id,
      email: object.email,
      first_name: object.first_name,
      last_name: object.last_name,
      reputation: 82,
      name: name,
      self_questions: self_questions,
      self_answers: self_answers,
      questions_count: object.questions.count,
      answers_count: 0,
      answered_questions: answered_questions
    }
  end

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end
end
