# frozen_string_literal: true

class Income < ApplicationRecord
  belongs_to :product, inverse_of: :incomes
  validates :period, format: { with: /\d{4}-\d{2}-\d{2}/,
    message: 'only allows dates' }, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
