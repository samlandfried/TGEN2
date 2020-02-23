# frozen_string_literal: true

require 'rails_helper'
require 'vcr_helper'

RSpec.describe NYT, :vcr do
  it 'can make a sentence' do
    expect(NYT.new.sentence).to equal('A sentence from an NYT article')
  end

  skip 'can make a different sentence' do
    expect(nyt.new.make_sentence).to_not equal('a sentence from an nyt article')
    expect(nyt.new.make_sentence.length).to be_greater_than(0)
  end
end
