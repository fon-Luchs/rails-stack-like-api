require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  it { should be_a ApplicationController }

  let(:user) { stub_model User }

  let(:password) { FFaker::Internet.password }

  let(:email) { FFaker::Internet.email }

  let(:first_name) { FFaker::Name.first_name }

  let(:last_name) { FFaker::Name.last_name }

  let(:params) do
    { user:
      {
        email: email,
        first_name: first_name,
        last_name:  last_name,
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
    before { get :create, params: params, format: :json }

    it { should render_template :show }
  end

  describe '#update.json' do
    before { resource_builder }

    before { expect(user).to receive(:update).and_return(true) }

    context 'PUT' do
      before { put :update, format: :json, params: params }

      it { should render_template :update }
    end
  end

  describe '#destroy.json' do
    let(:header) { { Authorization: "Token #{user.auth_token}" } }
    before { resource_builder }

    before do
      request.headers.merge! header
      delete :destroy, format: :json
    end

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
