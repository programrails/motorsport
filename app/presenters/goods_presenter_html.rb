# frozen_string_literal: true

# app/presenters/goods_presenter_html.rb
# https://devblast.com/b/poro-json-presenters
class GoodsPresenterHtml
  def initialize(result, from, to)
    result = result.to_a
    @total = result.pop['revenue']
    @results = result
    @from = from.to_s
    @to = to.to_s
  end

  def format
    {
      goods: @results,
      total_revenue: @total
    }
  end
end
