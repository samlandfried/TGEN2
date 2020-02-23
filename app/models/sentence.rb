# frozen_string_literal: true

class Sentence < ApplicationRecord
  validates :original, presence: true
  validates_uniqueness_of :original

  has_many :questions, dependent: :destroy
end
