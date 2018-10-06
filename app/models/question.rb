class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :rates, as: :rateable, touch: true, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 5 }

  validates :body, presence: true
  validates :body, length: { minimum: 5 }

  after_tuch :set_rating
  ater_touch :set_user_reputation

  def set_rating
    self.rating = rating.increment if rates.value == 1
    self.rating = rating.decrement if rates.value == -1
  end

  def set_user_reputation
    user.reputation = user.reputation.increment if rates.value == 1
    user.reputation = user.reputation.decrement if rates.value == -1
  end
end
