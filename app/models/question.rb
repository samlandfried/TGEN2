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

  private

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
  end

  def create_correct_option
    options.create(name: word_under_test, correct: true)
  end
end
