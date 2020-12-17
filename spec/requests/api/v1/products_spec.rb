describe 'Api::V1::ProductsController', type: :request do
  describe 'POST api/v1/products' do
    context 'when params are valid' do
      it 'creates a new product' do
        params = { product: { barcode: '123456', name: 'Water', unit: 'szt.' } }

        post('/api/v1/products', params: params)

        expect(response).to have_http_status(:success)
        expect(json_body).to match(
          {
            'data' =>
            {
              'id' => a_kind_of(String),
              'type' => 'product',
              'attributes' => {
                'barcode' => '123456', 'name' => 'Water', 'unit' => 'szt.'
              }
            }
          }
        )
      end
    end

    context 'when require fields are blank' do
      it 'returns an error message' do
        params = { product: { barcode: nil, name: nil, unit: nil } }

        post('/api/v1/products', params: params)

        expect(response).to have_http_status(:bad_request)
        expect(json_body).to eq(
          {
            'errors' =>
            {
              'barcode' => ["can't be blank"],
              'name' => ["can't be blank"],
              'unit' => ["can't be blank"]
            }
          }
        )
      end
    end

    context 'when barcode is already taken' do
      it 'returns an error message' do
        create(:product, barcode: 123_456, name: 'Water', unit: 'szt.')
        params = { product: { barcode: '123456', name: 'Water', unit: 'szt.' } }

        post('/api/v1/products', params: params)

        expect(response).to have_http_status(:bad_request)
        expect(json_body).to eq(
          {
            'errors' =>
            {
              'barcode' => ['has already been taken']
            }
          }
        )
      end
    end
  end
end
