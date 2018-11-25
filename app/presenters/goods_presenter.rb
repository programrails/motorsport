# frozen_string_literal: true

# app/presenters/goods_presenter.rb
# https://devblast.com/b/poro-json-presenters
class GoodsPresenter
  def initialize(result, from, to)
    result = result.to_a
    @total = result.pop['revenue']
    @results = result
    @from = from.to_s
    @to = to.to_s
  end

  def as_json(*)
    {
      from: @from,
      to: @to,
      goods: @results,
      total_revenue: @total
    }
  end
end
