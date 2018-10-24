class QuestionsController < BaseController
  before_action :build_resource, only: :create

  def update
    if current_user.id == resource.id
      super
    else
      render errors: 'FORBBIDEN', status: 403
    end
  end

  private

  def build_resource
    @question = current_user.questions.new resource_params
  end

  def resource
    @question ||= Question.find(params[:id])
  end

  def resource_params
    params.require(:question).permit(:title, :body)
  end

  def collection
    @questions = QuestionSearcher.new(search_params).search
  end

  def search_params
    params.permit(:title, :body)
  end
end
