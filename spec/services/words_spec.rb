# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe Words, :vcr do
  before(:each) do
    @words = Words.new
    @hatchback = 'hatchback'
  end

  it 'can get info on a word' do
    hatchback_details = @words.word(@hatchback)
    expect(hatchback_details[:word]).to eq(@hatchback)
  end

  it 'can fetch a random word' do
    random = @words.random_word
    expect(random[:word]).to be_a String
    expect(random[:word].length).to be > 0
  end

  it 'can fetch a random word similar to a given word' do
    hatchback = @words.word(@hatchback)
    similar_to_hatchback = @words.random_word(@hatchback)

    expect(similar_to_hatchback[:word]).to_not eq hatchback[:word]
    expect(similar_to_hatchback[:word].length).to be >= hatchback[:word].length - 3
    expect(similar_to_hatchback[:word].length).to be <= hatchback[:word].length + 3
    expect(similar_to_hatchback[:frequency]).to be >= hatchback[:frequency] - 0.5
    expect(similar_to_hatchback[:frequency]).to be <= hatchback[:frequency] + 0.5
    expect(similar_to_hatchback[:partofspeech]).to eq hatchback[:partofspeech]
  end
end
