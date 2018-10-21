class RateCounter
  def initialize(resource = nil)
    @rate = resource
    @klass = @rate.rateable_type.constantize
    @parent = @klass.find(@rate.rateable_id)
    @user = User.find(@parent.user_id)
  end

  def set_counter!
    set_rating
    set_reputation
  end

  private

  def set_rating
    @parent.increment(:rating) if @rate.positive?
    @parent.decrement(:rating) if @rate.negative?
    @parent.save
  end

  def set_reputation
    @user.increment(:reputation) if @rate.positive?
    @user.decrement(:reputation) if @rate.negative?
    @user.save
  end
end
