# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection.html
  protect_from_forgery unless: -> { request.format.json? }

  private

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def check_params(params, &fail_render)
    fail_render.call('The "to" and/or "from" params are missing.') and return false if params[:from].blank? || params[:to].blank?

    begin
      from = Date.strptime(params[:from], '%Y-%m-%d')

      to = Date.strptime(params[:to], '%Y-%m-%d')
    rescue StandardError
      fail_render.call('The params are not the date values.') and return false
    end

    fail_render.call('The start date has to be earlier than the end date.') and return false if from > to

    true
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity
end
