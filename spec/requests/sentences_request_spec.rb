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
end
