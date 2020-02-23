# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe 'Sentences', :vcr, type: :request do
  it 'gets sentences' do
    get '/sentences.json'

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(JSON.parse(response.body).length).to eq(20)
  end

  it 'saves sentence' do
    sentences = NYT.new.sentences
    post '/sentences', params: { sentence: { original: sentences.first } }

    expect(response).to have_http_status(:created)
    expect(Sentence.all.length).to eq(1)
    expect(Sentence.first.original).to eq(sentences.first)
  end
end
