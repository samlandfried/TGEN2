# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe 'Questions', :vcr, type: :request do
  it 'Creates questions with new sentences' do
    sentence = 'A new sentence'
    post '/questions', params: { question: { sentence: sentence } }

    expect(response).to have_http_status(:created)
    expect(Question.first.sentence.original).to eq(sentence)
  end

  it 'Creates questions with existing sentences' do
    sentence = 'A new sentence'
    Sentence.create(original: sentence)
    post '/questions', params: { question: { sentence: sentence } }

    expect(response).to have_http_status(:created)
    expect(Question.count).to eq(1)
    expect(Question.first.sentence.original).to eq(sentence)
  end
end
