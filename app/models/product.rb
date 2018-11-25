# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :incomes, inverse_of: :product, dependent: :destroy
  validates :title, length: { maximum: 128 }, presence: true
end
