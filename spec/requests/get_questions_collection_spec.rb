require 'rails_helper'

RSpec.describe 'GetQustionsCollection', type: :request do
  before { create_list(:question, 1, :with_answers) }

  let(:user) { create(:user, :with_auth_token, :with_questions_and_answers)}

  let(:value) { user.auth_token.value }

  let(:headers) { { 'Authorization' => "Token token=#{value}", 'Content-type' => 'application/json', 'Accept' => 'application/json' } }

  let(:questions_collection) do
    Question.all.order('rating DESC').map do |question|
      {
        "id" => question.id,
        "title" => question.title,
        "body" => question.body,
        "rating" => question.rating,
        "author" => {
          "id" => question.user.id,
          "reputation" => question.user.reputation,
          "name" => "#{ question.user.first_name } #{ question.user.last_name }"
        },
        "answers" => question.answers.order('rating DESC').map do |answer|
            {
              "id" => answer.id,
              "body" => answer.body,
              "rating" => answer.rating,
              "author" => {
                "id" => answer.user.id,
                "reputation" => answer.user.reputation,
                "name" => "#{ answer.user.first_name } #{ answer.user.last_name }"
              }
            }
          end
        }
    end
  end

  context do
    before { get '/questions', params: {} , headers: headers }

    it('returns collection of questions') { expect(JSON.parse(response.body)).to eq questions_collection }

    it('returns HTTP Status Code 200') { expect(response).to have_http_status 200 }
  end
end
