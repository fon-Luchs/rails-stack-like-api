require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { stub_model User }

  describe '#index.json' do
    before { expect(User).to receive(:all).and_return(user) }

    before { get :index, format: :json }

    it { should render_template :index }
  end

  describe '#show.json' do
    before { expect(User).to receive(:find).with(user.id).and_return(user) }

    it { should render_template :show }
  end
end
