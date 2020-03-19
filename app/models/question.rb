# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :sentence
  has_many :options

  after_create :create_options
  before_save :assign_word_under_test_index

  def word_under_test
    sentence.words[word_under_test_index]
  end

  def correct
    options.find_by(correct: true)
  end

  def create_incorrect_option
    word_details = words_api.random_word(word_under_test)
    options.create(name: word_details[:word])
  end

  def self.from_nyt
    create(sentence: Sentence.create_from_nyt)
  end

  private

  def words_api
    Words.new
  end

  def assign_word_under_test_index
    if word_under_test_index
      unless sentence.testable_words.include?(word_under_test_index)
        raise 'Word under test is not a testable word'
      end

      self.word_under_test_index = word_under_test_index
    else
      self.word_under_test_index = sentence.testable_words.sample
    end
  end

  def create_options
    create_correct_option
    3.times { create_incorrect_option }
  end

  def create_correct_option
    options.create(name: word_under_test, correct: true)
  end
end
