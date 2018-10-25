require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it { should be_a BaseController }

  describe '#create.json' do
    let(:session) { double }

    let(:password) { FFaker::Internet.password }

    let(:email) { FFaker::Internet.email }

    let(:params) { { session: { email: email, password: password } } }

    let(:permitted_params) { permit_params! params, :session }

    before { expect(Session).to receive(:new).with(permitted_params).and_return(session) }

    context do
      before { expect(session).to receive(:save).and_return(true) }
      def resource
        @user ||= current_user
      end
      before { post :create, params: params, format: :json }

      it { should render_template :create }
    end

    context do
      before { expect(session).to receive(:save).and_return(false) }

      before { post :create, params: params, format: :json }

      it { expect(response).to have_http_status(422) }

      it { expect(response.body).to eq('UNKNOW USER') }
    end
  end

  describe 'routes test' do
    it { should route(:delete, '/session').to(controller: :sessions, action: :destroy) }

    it { should route(:post, '/session').to(controller: :sessions, action: :create) }
  end
end
