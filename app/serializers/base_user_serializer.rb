class BaseUserSerializer < BaseUserAttrSerializer
  attributes :reputation, :name

  def name
    { name: object.first_name + ' ' + object.last_name }
  end
end
