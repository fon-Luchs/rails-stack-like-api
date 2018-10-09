class TestSerializer < ActiveModel::Serializer
  attributes :id, :tst

  has_many :questions

  def tst
    { id: object.id }
  end
end
