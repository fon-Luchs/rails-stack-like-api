class RatesController < BaseController
  def create
    if rate_builder.check_rate
      render errors: 'FORBBIDEN', status: 403
    else
      super
    end
  end

  private

  def resource
    @rate = rate_builder.build!
    @rate
  end

  def resource_params
    params.require(:rate).permit(:kind).merge(user: current_user)
  end

  def rate_builder
    rate_builder = RateBuilder.new(current_user, params, resource_params)
    rate_builder
  end
end
