# frozen_string_literal: true

FREQUENCY_THRESHOLD = 4.0
LENGTH_THRESHOLD = 3

class Sentence < ApplicationRecord
  validates :original, presence: true
  validates_uniqueness_of :original

  has_many :questions, dependent: :destroy

  def testable_words
    word_details.each_with_index.each_with_object([]) do |(word, i), memo|
      memo.push(i) if low_frequency?(word) && long_enough?(word)
      memo
    end
  end

  private

  def just_words
    original.gsub(/[^a-z ]/i, '').split(' ')
  end

  def word_details
    @words ||= Words.new
    just_words.map { |word| @words.word(word) }
  end

  def low_frequency?(word)
    word[:frequency] < FREQUENCY_THRESHOLD if word[:frequency]
  end

  def long_enough?(word)
    word[:word].length > LENGTH_THRESHOLD
  end
end
