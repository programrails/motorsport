# frozen_string_literal: true

class MainController < ApplicationController
  # GET /sales
  def index; end

  # POST /sales
  def create
    return unless check_params sales_params, &fail_render

    result = RevenueReportService.call(sales_params[:from], sales_params[:to])

    @result = GoodsPresenterHtml.new(result, sales_params[:from], sales_params[:to]).format
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sales_params
    params.require(:sales).permit(:from, :to)
  end

  def fail_render
    ->(error_message) { flash.now[:alert] = error_message }
  end
end
