require 'rails_helper'

RSpec.describe 'SalesRequests', type: :request do
  describe 'GET /sales' do
    let(:no_params) { '{"errors":"The \\"to\\" and/or \\"from\\" params are missing."}' }
    let(:no_data_params) { '{"errors":"The params are not the date values."}' }
    let(:ok_response) { '{"from":"2017-03-01","to":"2017-03-02","goods":[{"title":"Product","revenue":"128119.42"}],"total_revenue":"128119.42"}' }

    context 'correct response' do
      before(:each) do
        create(:product_full)
        get sales_path, params: { from: '2017-03-01', to: '2017-03-02' }
      end

      it 'shows OK' do
        expect(response).to have_http_status(200)
      end

      it 'returns no params error' do
        expect(response.body).to eq ok_response
      end
    end

    context 'no params' do
      before(:each) do
        get sales_path
      end

      it 'shows error no params' do
        expect(response).to have_http_status(422)
      end

      it 'returns no params error' do
        expect(response.body).to eq no_params
      end
    end

    context 'one param' do
      before(:each) do
        get sales_path, params: { from: '2017-03-01' }
      end

      it 'shows error no params' do
        expect(response).to have_http_status(422)
      end

      it 'returns no params error' do
        expect(response.body).to eq no_params
      end
    end

    context 'wrong param' do
      before(:each) do
        get sales_path, params: { from: '2017/03-01', to: '2017-03-02' }
      end

      it 'shows error no params' do
        expect(response).to have_http_status(422)
      end

      it 'returns no params error' do
        expect(response.body).to eq no_data_params
      end
    end
  end
end
