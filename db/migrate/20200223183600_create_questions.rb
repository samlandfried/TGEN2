# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :sentence, index: true, foreign_key: true, required: true

      t.timestamps
    end
  end
end
