require 'rails_helper'

RSpec.describe 'ShoppingCarts', type: :request do
  shared_examples 'a response with a flash message' do
    it 'renders the flash message' do
      request

      expect(flash[:alert]).to eq(flash_message)
    end
  end

  describe 'GET /show/:id' do
    subject(:request) { get "/shopping_carts/#{shopping_cart_id}" }

    context 'when there is no current_user' do
      let(:shopping_cart_id) { 1 }
      let(:flash_message) { 'You need to be logged in to do this action' }

      it_behaves_like 'a response with a flash message'
    end

    context 'when there is a current_user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'when the shopping cart cannot be found' do
        let(:shopping_cart_id) { :invalid }
        let(:flash_message) { 'Resource not available' }

        it_behaves_like 'a response with a flash message'
      end

      context 'when the shopping cart can be found' do
        let(:shopping_cart_id) { user.shopping_cart.id }

        it 'returns a http success response' do
          request

          expect(response).to have_http_status(:success)
        end
      end

      context 'when the shopping cart is from another user' do
        let(:another_user) { create(:user) }
        let(:shopping_cart_id) { another_user.shopping_cart.id }
        let(:flash_message) { 'Unauthorized' }

        it 'redirects to the root path' do
          request

          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'PUT /update' do
    subject(:request) { put "/shopping_carts/#{shopping_cart_id}" }

    context 'when there is no current_user' do
      let(:shopping_cart_id) { 1 }
      let(:flash_message) { 'You need to be logged in to do this action' }

      it_behaves_like 'a response with a flash message'
    end

    context 'when there is a current_user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'when the shopping cart cannot be found' do
        let(:shopping_cart_id) { :invalid }
        let(:flash_message) { 'Resource not available' }

        it_behaves_like 'a response with a flash message'
      end

      context 'when the shopping cart can be found' do
        let(:book_1) { create(:book, stock_quantity: 50) }
        let(:book_2) { create(:book, stock_quantity: 50) }
        let(:shopping_cart_id) { user.shopping_cart.id }

        before do
          user.shopping_cart.books << [book_1, book_2]
        end

        it 'updates the status of the shopping_cart' do
          expect { request }
            .to change { user.shopping_cart.reload.status }.from('in_progress').to('completed')
        end

        it 'decreases the stock_quantity of the books' do
          expect { request }.to change { book_1.reload.stock_quantity }.from(50).to(49)
                            .and change { book_2.reload.stock_quantity }.from(50).to(49)
        end
      end
    end
  end
end
