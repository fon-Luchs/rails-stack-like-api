module ReputationCounter
  def set_rating
    rating.increment if rate_positive?
    rating.decrement if rate_negative?
  end

  def set_reputation
    user.reputation.increment if rate_positive?
    user.reputation.decrement if rate_negative?
  end

  def rate_positive?
    rate.kind.positive?
  end

  def rate_negative?
    rate.kind.negative?
  end
end