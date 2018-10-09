require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user, :with_auth_token)}

  let(:value) { user.auth_token.value }

  let(:headers) do
    {
      'Authorization' => "Token token=#{value}",
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  let(:answer) { stub_model Answer }

  let(:question) { stub_model Question }

  let(:body)     { FFaker::LoremUA.phrase }

  let(:params) do
    {
      answer: { body: body, question_id: question.id }
    }
  end

  let(:permitted_params) { permit_params! params, :answer }

  describe '#create.json' do
    let(:request_params) do
      { body: body, question_id: question.id.to_s, user_id: user.id.to_s }
    end

    before { resource_builder }

    context 'success' do
      before { expect(answer).to receive(:save).and_return(true) }

      before { request.headers.merge!(headers) }

      before { post :create, params: request_params, format: :json }

      it { expect(response.body).to eq(BaseAnswerSerializer.new(answer).to_json) }
    end

    context 'fails' do
      before { expect(question).to receive(:save).and_return(false) }

      before { post :create, params: request_params, format: :json }

      it { should render_template :errors }
    end
  end

  describe '#show.json' do
    let(:request_params) { { id: answer.id.to_s, question_id: question.id.to_s } }

    before { expect(Answer).to receive(:find).with(answer.id.to_s).and_return(answer) }

    before { request.headers.merge!(headers) }

    before { get :show, params: request_params, format: :json }

    it { expect(response.body).to eq(BaseAnswerSerializer.new(answer).to_json) }
  end

  describe 'routes test' do
    it { should route(:get, '/questions/1/answers').to(action: :show, question_id: 1) }

    it { should route(:post, '/questions/1/answers').to(action: :create, question_id: 1) }
  end

  def resource_builder
    expect(user).to receive_message_chain(:answers, :new)
      .with(no_args).with(permitted_params)
      .and_return(answer)
  end
end
