class QuestionDecorator < Draper::Decorator
  delegate_all
  decorates_associations :user
  decorates_associations :answers, context: { id: :id, body: :body, rating: :rating }

  def author
    user = User.find(object.user_id).decorate if user.nil?
    {
      id: user.id,
      reputation: user.reputation,
      name: user.name
    }
  end

  def params
    {
      id: object.id,
      title: object.title,
      body: object.body,
      rating: object.rating,
      author: author,
      answers: answers
    }
  end

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end
end
