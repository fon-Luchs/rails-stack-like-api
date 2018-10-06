class ProfileCreateSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :reputation
end
