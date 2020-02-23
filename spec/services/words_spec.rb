# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe Words, :vcr do
  it 'can get info on a word' do
    words = Words.new
    hatchback_details = words.word('hatchback')
    expect(hatchback_details[:word]).to eq('hatchback')
  end
end
