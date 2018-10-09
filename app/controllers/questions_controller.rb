class QuestionsController < ApplicationController
  def index
    @questions = QuestionsSearcher(params).search
  end

  def show
    @question = Question.find(params[:id])
  end

  def update
    render status: 403 unless question.user_id == current_user.id
    super
  end

  private

  def resource
    @question = current_user.questions.new resource_params
  end

  def resource_params
    params.require(:question).permit(:title, :body)
  end
end
