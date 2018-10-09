require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  before { sign_in user }

  describe '#index.json' do
    before { expect(User).to receive(:all).and_return(user) }

    before { request.headers.merge!(headers) }

    before { get :index, format: :json }

    it { expect(response.body).to eq(UserIndexSerializer.new(user).to_json) }
  end

  describe '#show.json' do
    before { expect(User).to receive(:find).with(user.id).and_return(user) }

    before { request.headers.merge!(headers) }

    before { get :index, format: :json }

    it { expect(response.body).to eq(UserShowSerializer.new(user).to_json) }
  end
end
