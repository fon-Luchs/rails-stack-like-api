class AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
  end

  private

  def resource
    @answer = current_user.answers.new resource_params
  end

  def resource_params
    params.require(:answer).permit(:body).merge(question_id: params[:id])
  end
end
