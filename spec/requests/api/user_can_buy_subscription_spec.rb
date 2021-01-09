RSpec.describe 'POST /api/subscriptions', type: :request do
  let(:user) {create (:user)}
  let(:user_headers) { user.create_new_auth_token}

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_stripe_token) { stripe_helper.generate_card_token}

  before(:each) { StripeMock.start }
  after(:each) { StripeMock.stop}

  let(:product) { stripe_helper.create_product}
  let!(:plan) do
    stripe_helper.create_plan(
      id: 'DreamTimePlan',
      amount: 50,
      currency: 'usd',
      interval: 'month',
      interval_count: 1,
      name: 'DreamTimePlan',
      product: product.id
    )
  end

  describe 'successfully' do
    before do
      post '/api/subscriptions',
      params: {
        stripeToken: valid_stripe_token
      },
      headers: user_headers
    end

    it 'is expected to return 201 response status' do
      expect(response).to have_http_status 201
    end

    it 'is expected to return a success message' do
      expect(response_json['message']).to eq 'You are now a subscriber'
    end

    it 'is expected to make user a subscriber' do
      expect(user.reload.role).to eq 'subscriber'
    end
  end

  describe 'unsuccessfully' do
    describe 'when card is declined' do
      before do
        StripeMock.prepare_card_error(:card_declined, :new_invoice)
        post '/api/subscriptions',
      params: {
        stripeToken: valid_stripe_token
      },
      headers: user_headers
      end
      
      it 'is expected to return 422 response status' do
        expect(response).to have_http_status 422
      end
  
      it 'is expected to return a error message' do
        expect(response_json['message']).to eq 'Something went wrong. The card was declined'
      end
  
      it 'is not expected to make user a subscriber' do
        expect(user.reload.role).to eq 'registered_user'
      end
    end
  end
end