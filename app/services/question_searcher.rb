class QuestionSearcher
  attr_reader :title, :body

  def initialize(params = {})
    puts("#{params}")
    @title = params[:title] if params[:title]
    @body  = params[:body] if params[:body]
  end

  def search
    puts(">>>#{title}||#{body}<<<")
    collection = Question.where('title LIKE ? AND body LIKE ?', "%#{title}%", "%#{body}%")
    collection
  end
end
