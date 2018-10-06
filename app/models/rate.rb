class Rate < ApplicationRecord
  enum :kind [:positive, :negative]

  belongs_to :rateable, polymorphic: true

  before_save :set_value

  def set_value
    self.value = 1  if :positive?
    self.value = -1 if :negative?
  end
end
