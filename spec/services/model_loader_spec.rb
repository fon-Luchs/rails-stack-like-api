require 'rails_helper'

RSpec.describe ModelLoader do
  let(:user) { stub_model User }

  let(:params) { { user_id: user.id, article_id: 1, store_id: 10 } }

  let(:models) { [User, Question] }

  let(:model_loader) { ModelLoader.new models, params }

  describe '#initialize' do
    it { expect(model_loader.instance_variable_get(:@models)).to eq(models) }

    it { expect(model_loader.instance_variable_get(:@params)).to eq(params) }
  end

  describe '#load_rateable' do
    before do
      expect(self). to receive_message_chain(:models, :detect)
        .with(no_args).with("user_id")
        .and_return(models[0])
    end

    before do
      expect(models[0]).to receive(:wind)
        .with("user_id")
        .and_return(user)
    end

    it { expect(user).to eq(User.find(params[:user_id])) }
  end
end
