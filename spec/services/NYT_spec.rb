# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe NYT, :vcr do
  it 'can produce sentences' do
    nyt = NYT.new
    expect(nyt.sentences.length).to eq(20)
    expect(nyt.sentences.first).to eq('At the molecular level, soap breaks things apart. At the level of society, it helps hold everything together.')
    expect(nyt.sentences.last).to eq('This once-in-a-century pandemic is hitting a world economy saddled with record levels of debt.')
  end
end
