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

  def as_json(*args)
    if @context[:type] == 'Answer'
      answer_params
    else
      question_params
    end
  end
end
