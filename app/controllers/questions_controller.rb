class QuestionsController < BaseController
  before_action :build_resource, only: :create

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
    @questions = QuestionSearcher.new(params).search
  end
end
