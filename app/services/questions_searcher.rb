class QuestionsSearcher
  attr_reader :title, :body

  def initialize params
    @title = params[:title]
    @body  = params[:body]
  end

  def search
    collection = Questions.all

    if title == ''
      collection = collection.where('body ILIKE ?', "%#{body}")
    elsif body == ''
      collection = collection.where(' title ILIKE ?', "%#{title}%")
    else
      collection = collection.where(' title ILIKE ?', "%#{title}%", 'body ILIKE ?', "%#{body}")
    end

    collection
  end
end