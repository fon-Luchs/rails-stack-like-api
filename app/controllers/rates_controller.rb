class RatesController < BaseController
  after_action :run_rate

  private

  def resource
    @rate ||= RateBuilder.new(current_user, params, resource_params).build!
  end

  def resource_params
    params.require(:rate).permit(:kind).merge(user: current_user)
  end

  def run_rate
    RateCounter.new(resource).set_counter! if resource.save
  end
end
