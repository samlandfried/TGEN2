# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe NYT, :vcr do
  it 'can produce sentences' do
    nyt = NYT.new
    expect(nyt.sentences.length).to eq(20)
    expect(nyt.sentences.first).to eq('The matriarch of the large New Jersey family died Wednesday night without ever knowing that her two oldest children had died before her.')
    expect(nyt.sentences.last).to eq('Will we endure 2.2 million deaths? Or will we manage to turn things around?')
  end
end
