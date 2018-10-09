class QuestionsController < ApplicationController
  def index
    @questions = QuestionsSearcher(params).search
    render json: @questions, serializer: QuestionRelativeSerializer
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, serializer: QuestionRelativeSerializer
  end

  def update
    if resource.user_id == current_user.id
      super
    else
      render status: 403, json: 'Forbidden'
    end
  end

  private

  def resource
    @question ||= current_user.questions.new resource_params
  end

  def resource_params
    params.require(:question).permit(:title, :body)
  end

  def resource_response
    render json: resource, serializer: QuestionRelativeSerializer
  end
end
