require 'rails_helper'

RSpec.describe 'Incomes', type: :request do
  context 'test income paths' do
    let(:product) { create(:product_full) }
    let(:income1) { "{\"id\":#{product.incomes.first.id},\"period\":\"#{product.incomes.first.period.iso8601(3)}\",\"value\":\"#{product.incomes.first.value}\",\"product_id\":#{product.id},\"created_at\":\"#{product.incomes.first.created_at.iso8601(3)}\",\"updated_at\":\"#{product.incomes.first.updated_at.iso8601(3)}\"}" }
    let(:income2) { "{\"id\":#{product.incomes.second.id},\"period\":\"#{product.incomes.second.period.iso8601(3)}\",\"value\":\"#{product.incomes.second.value}\",\"product_id\":#{product.id},\"created_at\":\"#{product.incomes.second.created_at.iso8601(3)}\",\"updated_at\":\"#{product.incomes.second.updated_at.iso8601(3)}\"}" }
    let(:income1_2) { '[' + income1 + ',' + income2 + ']' }
    let(:auth_errors) { '{"errors":["You need to sign in or sign up before continuing."]}' }

    context 'authorised paths' do
      let(:current_user) { create(:user) }
      let(:auth_params) { login current_user }

      describe 'GET /api/v1/products/id/incomes' do
        before(:each) do
          get api_v1_product_incomes_path(product.id), headers: auth_params
        end

        it 'returns OK' do
          expect(response).to have_http_status(200)
        end

        it 'returns good response' do
          expect(response.body).to eq(income1_2)
        end
      end

      describe 'GET /api/v1/products/id/incomes/id' do
        before(:each) do
          get api_v1_product_income_path(product.id, product.incomes.first.id), headers: auth_params
        end

        it 'returns OK' do
          expect(response).to have_http_status(200)
        end

        it 'returns good response' do
          expect(response.body).to eq(income1)
        end
      end
    end

    context 'non-authorised paths' do
      describe 'GET /api/v1/products/id/incomes' do
        before(:each) do
          get api_v1_product_incomes_path(product.id)
        end

        it 'returns 401' do
          expect(response).to have_http_status(401)
        end

        it 'returns auth error response' do
          expect(response.body).to eq(auth_errors)
        end
      end

      describe 'GET /api/v1/products/id/incomes/id' do
        before(:each) do
          get api_v1_product_income_path(product.id, product.incomes.first.id)
        end

        it 'returns 401' do
          expect(response).to have_http_status(401)
        end

        it 'returns auth error response' do
          expect(response.body).to eq(auth_errors)
        end
      end
    end
  end
end
