class AnswerDecorator < Draper::Decorator
  delegate_all
  decorates_associations :user

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
      body: object.body,
      rating: object.rating,
      author: author
    }
  end

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end
end
