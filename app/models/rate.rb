class Rate < ApplicationRecord
  belongs_to :rateable, polymorphic: true

  enum kind: { possitive: 1, negative: -1 }
end
