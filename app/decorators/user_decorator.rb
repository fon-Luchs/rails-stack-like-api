class UserDecorator < Draper::Decorator
  delegate_all

  def self_questions
    [
      {
        id: 123,
        title: 'Dread',
        rating: -3
      }
    ]
  end

  def self_answers
    []
  end

  def as_json(*args)
    {
      id: object.id,
      email: object.email,
      first_name: object.first_name,
      last_name: object.last_name,
      reputation: 82,
      self_questions: self_questions,
      self_answers: self_answers
    }
  end

end
