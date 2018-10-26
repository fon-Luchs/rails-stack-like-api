class Rate < ApplicationRecord
  belongs_to :rateable, polymorphic: true
  belongs_to :user

  after_create :run_rate

  validates :kind, presence: true

  enum kind: [:positive, :negative]

  private

  def run_rate
    RateCounter.new(self).rating_calculation!
  end
end
