# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NYT do
  it 'can make a sentence' do
    expect(NYT.new.make_sentence).to equal('A sentence from an NYT article')
  end

  it 'can make a different sentence' do
    expect(NYT.new.make_sentence).to_not equal('A sentence from an NYT article')
    expect(NYT.new.make_sentence.length).to be_greater_than(0)
  end
end
