require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { stub_model Question }

  let(:user)     { create(:user, :with_auth_token) }

  let(:title)    { FFaker::LoremUA.phrase }

  let(:body)     { FFaker::LoremUA.phrase }

  let(:params) do
    {
      question: { title: title, body: body }
    }
  end

  let(:permitted_params) { permit_params! params, :question }

  let(:request_params)   { { question: { title: title, body: body, user_id: user.id.to_s } } }

  describe '#create.json' do
    before { resource_builder }

    context 'success' do
      before { expect(question).to receive(:save).and_return(true) }

      before { post :create, params: request_params, format: :json }

      it { should render_template :create }
    end

    context 'fails' do
      before { expect(question).to receive(:save).and_return(false) }

      before { post :create, params: request_params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    let(:request_params) { { title: title, body: body, id: question.id.to_s } }

    before { resource_builder }

    before { expect(question).to receive(:update).and_return(true) }

    context 'PUT' do
      before { put :update, params: request_params, format: :json }

      it { should render_template :update }
    end
  end

  describe '#show.json' do
    before { expect(Question).to receive(:find).with(question.id).and_return(question) }

    before { get :show, params: { id: question.id.to_s }, format: :json }

    it { should render_template :show }
  end

  describe '#ihdex.json' do
    let(:request_params) { { title: title, body: body } }

    before do
      expect(QuestionsSearcher).to receive_message_chain(:new, :search)
        .with(request_params).with(no_args)
        .and_return(question)
    end

    before { get :index, params: request_params, format: :json }

    it { should render_template :index }
  end

  describe 'routes test' do
    it { should route(:get, '/questions/1').to(action: :show, id: 1) }

    it { should route(:get, '/questions').to(action: :index) }

    it { should route(:post, '/questions').to(action: :create) }

    it { should route(:put, '/questions/1').to(action: :update, id: 1) }
  end

  def resource_builder
    expect(user).to receive_message_chain(:questions, :new)
      .with(no_args).with(permitted_params)
      .and_return(question)
  end
end
