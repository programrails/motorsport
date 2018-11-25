# frozen_string_literal: true

class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.datetime :period, null: false
      t.decimal :value, precision: 8, scale: 2, null: false
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
