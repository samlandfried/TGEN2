# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.string :name, null: false, index: true
      t.boolean :correct, default: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
