require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  it { should be_a ApplicationController }

  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:password) { FFaker::Internet.password }

  let(:params) do
    { user:
      {
        email: user.email,
        first_name: user.first_name,
        last_name:  user.last_name,
        password: password,
        password_confirmation: password
      } }
  end

  let(:permitted_params) { permit_params! params, :user }

  before { sign_in user }

  describe '#create.json' do
    before { resource_builder }

    context 'success' do
      before { expect(user).to receive(:save).and_return(true) }

      before { post :create, params: params, format: :json }

      it { expect(response.body).to eq(ProfileSerializer.new(user).to_json) }
    end

    context 'fail' do
      before { expect(user).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    before { request.headers.merge!(headers) }

    before { get :create, params: params, format: :json }

    it { expect(response.body).to eq(ProfileSerializer.new(user).to_json) }
  end

  describe '#update.json' do
    before { resource_builder }

    before { request.headers.merge!(headers) }

    before { expect(user).to receive(:update).and_return(true) }

    context 'PUT' do
      before { put :update, format: :json, params: params }

      it { expect(response.body).to eq(ProfileSerializer.new(user).to_json) }
    end
  end

  describe '#destroy.json' do
    before { resource_builder }

    before { request.headers.merge!(headers) }

    before { delete :destroy, format: :json }

    it { expect(response.body).to eq('204 No Content') }
  end

  describe 'routes test' do
    it { should route(:get, '/profile').to(action: :show, ) }

    it { should route(:post, '/profile').to(action: :create) }

    it { should route(:put, '/profile').to(action: :update) }

    it { should route(:delete, '/profile').to(action: :destroy) }
  end

  def resource_builder
    expect(User).to receive(:new).with(permitted_params).and_return(user)
  end
end
