class SessionSerializer < ActiveModel::Serializer
  attributes :auth_token

  def auth_token
    { auth_token: :value }
  end
end
