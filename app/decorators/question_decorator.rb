class QuestionDecorator < Draper::Decorator
  delegate_all
  decorates_associations :user

  def author
    user = User.find(object.user_id).decorate if user.nil?
    {
      id: user.id,
      reputation: 32,
      name: user.name
    }
  end

  def params
    {
      id: object.id,
      title: object.title,
      body: object.body,
      rating: 133,
      author: author,
      answers: []
    }
  end

  def as_json(*args)
    params.select { |key, value| @context.key? key }
  end
end
