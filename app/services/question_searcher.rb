class QuestionSearcher
  attr_reader :title, :body

  def initialize(params = {})
    @title = params[:title] if params[:title]
    @body  = params[:body] if params[:body]
  end

  def search
    collection = Question.where('title LIKE ? AND body LIKE ?', "%#{title}%", "%#{body}%")
    collection.order('rating DESC')
  end
end
