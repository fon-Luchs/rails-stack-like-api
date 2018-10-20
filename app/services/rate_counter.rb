class RateCounter
  def initialize(resource = nil)
    @rate = resource
    @user = User.find(@rate.user_id)
    @klass = @rate.rateable_type.constantize
  end

  def set_counter
    set_rating
    set_reputation
  end

  private

  def set_rating
    @klass.increment(:rating) if @rate.positive?
    @klass.decrement(:rating) if @rate.negative?
    @klass.save
  end

  def set_reputation
    @user.increment(:reputation) if @rate.positive?
    @user.decrement(:reputation) if @rate.negative?
    @user.save
  end
end
