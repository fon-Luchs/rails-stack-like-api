require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { stub_model Question, user_id: user.id }

  let(:user)     { create(:user, :with_auth_token) }

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:title)    { FFaker::LoremUA.phrase }

  let(:body)     { FFaker::LoremUA.phrase }

  let(:params) do
    {
      question: { title: title, body: body }
    }
  end

  before { sign_in user }

  let(:permitted_params) { permit_params! params, :question }

  let(:request_params)   { { question: { title: title, body: body, user_id: user.id.to_s } } }

  describe '#create.json' do
    before { resource_builder }

    context 'success' do
      before { expect(question).to receive(:save).and_return(true) }

      before { request.headers.merge!(headers) }

      before { post :create, params: request_params, format: :json }

      it { expect(response.body).to eq(QuestionRelativeSerializer.new(question).to_json) }
    end

    context 'fails' do
      before { expect(question).to receive(:save).and_return(false) }

      before { request.headers.merge!(headers) }

      before { post :create, params: request_params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#update.json' do
    let(:request_params) { { title: title, body: body, id: question.id.to_s } }

    before { resource_builder }

    before { expect(question).to receive(:update).and_return(true) }

    context 'PUT' do
      before { request.headers.merge!(headers) }

      before { put :update, params: request_params, format: :json }

      it { expect(response.body).to eq(QuestionRelativeSerializer.new(question).to_json) }
    end
  end

  describe '#show.json' do
    before { expect(Question).to receive(:find).with(question.id.to_s).and_return(question) }

    before { request.headers.merge!(headers) }

    before { get :show, params: { id: question.id.to_s }, format: :json }

    it { expect(response.body).to eq(QuestionRelativeSerializer.new(question).to_json) }
  end

  describe '#ihdex.json' do
    let(:request_params) { { title: title, body: body } }

    before do
      expect(QuestionsSearcher).to receive_message_chain(:new, :search)
        .with(request_params).with(no_args)
        .and_return(question)
    end

    before { request.headers.merge!(headers) }

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
