class QuestionsSearcher
  attr_reader :title, :body

  def initialize(params = {})
    @title = params[:title] || ''
    @body  = params[:body]  || ''
  end

  def search
    collection = Questions.all
    collection = collection.where(' title ILIKE ?', "%#{title}%", 'AND', 'body ILIKE ?', "%#{body}")
    # CONDITITONS?
    collection
  end
end