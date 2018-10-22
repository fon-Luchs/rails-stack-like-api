class RatesController < BaseController
  private

  def resource
    @rate ||= RateBuilder.new(current_user, params, resource_params).build!
  end

  def resource_params
    params.require(:rate).permit(:kind).merge(user: current_user)
  end
end
