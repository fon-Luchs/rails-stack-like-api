class AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
    render json: @answer, serialize: BaseAnswerSerializer
  end

  private

  def resource
    @answer = current_user.answers.new resource_params
  end

  def resource_params
    params.require(:answer).permit(:body).merge(question_id: params[:question_id])
  end

  def resource_response
    render json: resource, serialize: BaseAnswerSerializer
  end
end
