# frozen_string_literal: true

FREQUENCY_THRESHOLD = 4.0
LENGTH_THRESHOLD = 3

class Sentence < ApplicationRecord
  validates :original, presence: true
  validates_uniqueness_of :original

  has_many :questions, dependent: :destroy

  before_create :validate_testability

  def testable_words
    word_details.each_with_index.each_with_object([]) do |(word, i), memo|
      memo.push(i) if testable?(word)
      memo
    end
  end

  private

  def just_words
    original.gsub(/[^a-z ]/i, '').split(' ')
  end

  def word_details
    @words_api ||= Words.new
    just_words.map { |word| @words_api.word(word) }
  end

  def word_found?(word)
    word && !!word[:word]
  end

  def low_frequency?(word)
    word[:frequency] < FREQUENCY_THRESHOLD
  end

  def long_enough?(word)
    word[:word].length > LENGTH_THRESHOLD
  end

  def testable?(word)
    word_found?(word) && low_frequency?(word) && long_enough?(word)
  end

  def validate_testability
    raise 'Sentence has no testable words' if testable_words.empty?
  end
end
