require 'rails_helper'

RSpec.describe 'GetQuestionAnswersCollection', type: :request do
  let!(:question) { create(:question, :with_answers, id: 1) }

  let(:user) { create(:user, :with_auth_token, :with_questions_and_answers)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:answers) do
    question.answers.order('rating DESC').map do |answer|
      {
        "id" => answer.id,
        "rating" => answer.rating,
        "body" => answer.body,
        "author" => {
          "id" => answer.user.id,
          "reputation" => answer.user.reputation,
          "name" => "#{ answer.user.first_name } #{ answer.user.last_name }"
        }
      }
    end
  end

  context do
    before { get '/questions/1/answers', params: {} , headers: headers }

    it("returns question's answers") { expect(JSON.parse(response.body)).to eq answers }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end

  context 'question was not found' do
    before { get '/questions/9/answers', params: {} , headers: headers }

    it('returns HTTP Status Code 404') { expect(response).to have_http_status 404 }
  end
end
