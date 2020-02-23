# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe NYT, :vcr do
  it 'can produce sentences' do
    nyt = NYT.new
    expect(nyt.sentences.length).to eq(20)
    expect(nyt.sentences.first).to eq('I was skeptical, but it turns out there is something to be said for a daily fast, preferably one lasting at least 16 hours.')
    expect(nyt.sentences.last).to eq('The $13 billion deal will give a powerful Wall Street firm control of a major presence in the world of online brokerage firms.')
  end
end
