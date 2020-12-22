describe 'Api::V1::InventoriesController', type: :request do
  describe 'POST api/v1/inventories' do
    context 'when params are valid' do
      it 'creates a new inventory' do
        product = create(:product, barcode: '123456', name: 'Water', unit: 'szt.')
        params = { inventory: { quantity: '1', price: '2', barcode: '123456' } }

        post('/api/v1/inventories', params: params)

        expect(response).to have_http_status(:success)
        expect(json_body).to match(
          {
            'data' =>
            {
              'id' => be_kind_of(String),
              'type' => 'inventory',
              'attributes' => { 'id' => be_kind_of(Integer), 'quantity' => '1.0', 'price' => '2.0' },
              'relationships' => { 'product' => { 'data' => { 'id' => product.id.to_s, 'type' => 'product' } } }
            },
            'included' =>
            [
              {
                'id' => product.id.to_s,
                'type' => 'product',
                'attributes' => { 'barcode' => '123456', 'name' => 'Water', 'unit' => 'szt.' }
              }
            ]
          }
        )
      end
    end

    context 'when requiredfields are blank' do
      it 'returns an error message' do
        params = { inventory: { quantity: nil, price: nil, barcode: nil } }

        post('/api/v1/inventories', params: params)

        expect(response).to have_http_status(:bad_request)
        expect(json_body).to match(
          'errors' =>
            {
              'product' => ['must exist'],
              'quantity' => ["can't be blank", 'is not a number'],
              'price' => ["can't be blank", 'is not a number'],
              'product_id' => ["can't be blank"]
            }
        )
      end
    end
  end

  describe 'GET api/v1/inventories' do
    it 'returns all inventories with products' do
      product = create(:product, barcode: 123_456, name: 'Water', unit: 'szt.')
      inventory = create(:inventory, product_id: product.id, quantity: 111, price: 222)
      product2 = create(:product, barcode: 654_321, name: 'Pepsi', unit: 'szt.')
      inventory2 = create(:inventory, product_id: product2.id, quantity: 333, price: 444)

      get('/api/v1/inventories')

      expect(response).to have_http_status(:ok)
      expect(json_body).to match(
        'data' =>
          [
            {
              'id' => inventory.id.to_s,
              'type' => 'inventory',
              'attributes' => { 'id' => inventory.id, 'quantity' => '111.0', 'price' => '222.0' },
              'relationships' => { 'product' => { 'data' => { 'id' => product.id.to_s, 'type' => 'product' } } }
            },
            {
              'id' => inventory2.id.to_s,
              'type' => 'inventory',
              'attributes' => { 'id' => inventory2.id, 'quantity' => '333.0', 'price' => '444.0' },
              'relationships' => { 'product' => { 'data' => { 'id' => product2.id.to_s, 'type' => 'product' } } }
            }
          ],
        'included' =>
          [
            {
              'id' => product.id.to_s,
              'type' => 'product',
              'attributes' => { 'barcode' => '123456', 'name' => 'Water', 'unit' => 'szt.' }
            },
            {
              'id' => product2.id.to_s,
              'type' => 'product',
              'attributes' => { 'barcode' => '654321', 'name' => 'Pepsi', 'unit' => 'szt.' }
            }
          ]
      )
    end
  end

  describe 'PATCH api/v1/inventories' do
    context 'when params are valid' do
      it 'updates a inventory' do
        product = create(:product, barcode: 123_456, name: 'Water', unit: 'szt.')
        inventory = create(:inventory, product_id: product.id, quantity: 111, price: 222)
        params = { inventory: { quantity: 333.5, price: 444.5 } }

        patch("/api/v1/inventories/#{inventory.id}", params: params)

        expect(response).to have_http_status(:success)
        expect(json_body).to match(
          'data' =>
            {
              'id' => inventory.id.to_s,
              'type' => 'inventory',
              'attributes' => { 'id' => inventory.id, 'quantity' => '333.5', 'price' => '444.5' },
              'relationships' => { 'product' => { 'data' => { 'id' => product.id.to_s, 'type' => 'product' } } }
            },
          'included' =>
            [
              {
                'id' => product.id.to_s,
                'type' => 'product',
                'attributes' => { 'barcode' => '123456', 'name' => 'Water', 'unit' => 'szt.' }
              }
            ]
        )
        inventory.reload
        expect(inventory).to have_attributes(quantity: 333.5, price: 444.5)
      end
    end

    context 'when requiredfields are blank' do
      it 'returns an error message' do
        product = create(:product, barcode: 123_456, name: 'Water', unit: 'szt.')
        inventory = create(:inventory, product_id: product.id, quantity: 111, price: 222)
        params = { inventory: { quantity: nil, price: nil } }

        patch("/api/v1/inventories/#{inventory.id}", params: params)

        expect(response).to have_http_status(:bad_request)
        expect(json_body).to match(
          'errors' => {
            'quantity' => ["can't be blank", 'is not a number'],
            'price' => ["can't be blank", 'is not a number']
          }
        )
        inventory.reload
        expect(inventory).to have_attributes(quantity: 111, price: 222)
      end
    end
  end
end
