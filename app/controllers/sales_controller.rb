# frozen_string_literal: true

class SalesController < ApplicationController
  # GET /sales
  def index
    return unless check_params params, &fail_render

    result = RevenueReportService.call(params[:from], params[:to])

    render json: GoodsPresenter.new(result, params[:from], params[:to])
  end

  private

  def fail_render
    ->(error_message) { render json: { errors: error_message }, status: :unprocessable_entity }
  end
end
