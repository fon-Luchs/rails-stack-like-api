class RateDecorator < Draper::Decorator
  delegate_all
  decorates_associations :rateable

  def author
    {
      id: rateable.user.id,
      reputation: rateable.user.reputation,
      name: rateable.user.name
    }
  end

  def answer_params
  {
    id: object.rateable.id,
    body: object.rateable.body,
    rating: object.rateable.rating,
    author: author
  }
  end

  def question_params
    {
      id: object.rateable.id,
      title: object.rateable.title,
      body: object.rateable.body,
      rating: object.rateable.rating,
      author: author,
      answers: object.rateable.answers
    }
  end

  def show_interface(type)
    case type
    when 'Answer'
      answer_params
    when 'Question'
      question_params
    end
  end

  def as_json(*args)
    show_interface(@context[:type])
  end
end
