# frozen_string_literal: true

json.extract! income, :id, :period, :value, :product_id, :created_at, :updated_at
json.url income_url(income, format: :json)
