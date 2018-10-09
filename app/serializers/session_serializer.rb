class SessionSerializer < ActiveModel::Serializer
  attributes :auth_token

  def auth_token
    object.auth_token.value
  end
end
