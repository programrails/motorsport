require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let!(:product) { create(:product) }
  let!(:product_full) { create(:product_full) }

  let(:valid_attributes) {
    { title: 'Product1' }
  }

  let(:invalid_attributes) {
    { title: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' }
  }

  let(:response1) { "{\"id\":#{product.id},\"title\":\"#{product.title}\",\"created_at\":\"#{product.created_at.iso8601(3)}\",\"updated_at\":\"#{product.updated_at.iso8601(3)}\"}" }
  let(:response2) { "{\"id\":#{product_full.id},\"title\":\"#{product_full.title}\",\"created_at\":\"#{product_full.created_at.iso8601(3)}\",\"updated_at\":\"#{product_full.updated_at.iso8601(3)}\"}" }
  let(:response1_2) { '[' + response1 + ',' + response2 + ']' }
  let(:auth_errors) { '{"errors":["You need to sign in or sign up before continuing."]}' }

  context 'authorised paths' do
    let(:current_user) { create(:user) }
    let(:auth_params) { login current_user }

    describe 'GET #index' do
      before(:each) do
        get api_v1_products_path, headers: auth_params
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns a correct response' do
        expect(response.body).to eq(response1_2)
      end
    end

    describe 'GET #show' do
      before(:each) do
        get api_v1_product_path(product.id), headers: auth_params
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns a correct response' do
        expect(response.body).to eq(response1)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Product' do
          expect {
            post api_v1_products_path, params: { product: valid_attributes }, headers: auth_params
          }.to change(Product, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'creates a new Product' do
          expect {
            post api_v1_products_path, params: { product: invalid_attributes }, headers: auth_params
          }.to change(Product, :count).by(0)
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          { title: 'Product1 Update' }
        }

        it 'updates the requested product' do
          put api_v1_product_path(product.id), params: { product: new_attributes }, headers: auth_params
          product.reload
          expect(product.title).to eq('Product1 Update')
        end

        it 'dont update with invalid product' do
          put api_v1_product_path(product.id), params: { product: invalid_attributes }, headers: auth_params
          product.reload
          expect(product.title).to eq('Product')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested product' do
        expect {
          delete api_v1_product_path(product.id), headers: auth_params
        }.to change(Product, :count).by(-1)
      end
    end
  end

  context 'non-authorised paths' do
    describe 'GET #index' do
      before(:each) do
        get api_v1_products_path
      end

      it 'returns 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns auth error response' do
        expect(response.body).to eq(auth_errors)
      end
    end

    describe 'GET #show' do
      before(:each) do
        get api_v1_product_path(product.id)
      end

      it 'returns 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns auth error response' do
        expect(response.body).to eq(auth_errors)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Product' do
          expect {
            post api_v1_products_path, params: { product: valid_attributes }
          }.to change(Product, :count).by(0)
        end

        context 'non-authorised' do
          before(:each) do
            post api_v1_products_path, params: { product: valid_attributes }
          end

          it 'returns 401' do
            expect(response).to have_http_status(401)
          end

          it 'returns auth error response' do
            expect(response.body).to eq(auth_errors)
          end
        end
      end

      context 'with invalid params' do
        it 'creates a new Product' do
          expect {
            post api_v1_products_path, params: { product: invalid_attributes }
          }.to change(Product, :count).by(0)
        end

        context 'non-authorised' do
          before(:each) do
            post api_v1_products_path, params: { product: invalid_attributes }
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

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) {
          { title: 'Product1 Update' }
        }

        it 'updates the requested product' do
          put api_v1_product_path(product.id), params: { product: new_attributes }
          product.reload
          expect(product.title).to eq('Product')
        end

        it 'dont update with invalid product' do
          put api_v1_product_path(product.id), params: { product: invalid_attributes }
          product.reload
          expect(product.title).to eq('Product')
        end

        context 'non-authorised' do
          before(:each) do
            put api_v1_product_path(product.id), params: { product: invalid_attributes }
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

    describe 'DELETE #destroy' do
      it 'destroys the requested product' do
        expect {
          delete api_v1_product_path(product.id)
        }.to change(Product, :count).by(0)
      end

      context 'non-authorised' do
        before(:each) do
          delete api_v1_product_path(product.id)
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
