# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe Words, :vcr do
  before(:each) do
    @words = Words.new
  end

  it 'can get info on a word' do
    hatchback_details = @words.word('hatchback')
    expect(hatchback_details[:word]).to eq('hatchback')
  end

  it 'can fetch a random word' do
    random = @words.random_word
    expect(random[:word]).to be_a String
    expect(random[:word].length).to be > 0
  end
end
