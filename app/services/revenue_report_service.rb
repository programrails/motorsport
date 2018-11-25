# frozen_string_literal: true

# Report a revenue info
class RevenueReportService < ApplicationService
  def initialize(from, to)
    @from = from
    @to = to
  end

  def call
    call_db_query
  end

  private

  def call_db_query
    # Tested on PostgreSQL 9.5.15
    query = <<-SQL
      SELECT
        products.title AS title,
        SUM(incomes.value) AS revenue
      FROM
        public.products
      LEFT OUTER JOIN incomes ON products.id = incomes.product_id
      WHERE incomes.period between '#{@from}' and '#{@to}'
      GROUP BY ROLLUP(products.title)
    SQL

    ActiveRecord::Base.connection.execute(query)
  end
end
