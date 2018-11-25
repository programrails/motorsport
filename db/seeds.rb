# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Income.destroy_all
Product.destroy_all

require 'roo'

file_path = './db/goods.xlsx'

spreadsheet = Roo::Spreadsheet.open file_path

header = spreadsheet.row(1)
header.shift

(2..spreadsheet.last_row).each do |i|
  break if spreadsheet.sheet(0).row(i).first.blank?

  spreadsheet_row = spreadsheet.row(i)

  product_title = spreadsheet_row.shift

  p product_title

  product = Product.create! title: product_title

  row = Hash[[header, spreadsheet_row].transpose]

  incomes_line = row.map { |k, v| { period: k, value: v.to_d } }

  product.incomes.create! incomes_line
end
