# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :sentence, index: true, foreign_key: true, null: false
      t.integer :word_under_test_index, null: false

      t.timestamps
    end
  end
end
