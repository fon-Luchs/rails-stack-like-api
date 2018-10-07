module ReputationCounter
  def set_rating
    rating.increment if rate_possitive?
    rating.decrement if rate_negative?
  end

  def set_reputation
    user.reputation.increament if rate_possitive?
    user.reputation.decrement  if rate_negative?
  end

  def rate_possitive?
    rate.kind.possitive?
  end

  def rate_negative?
    rate.kind.negative?
  end
end