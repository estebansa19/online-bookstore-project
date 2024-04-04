# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShoppingCarts::Books', type: :request do
  shared_examples 'a response with a flash message' do
    it 'renders the flash message' do
      request

      expect(response.body).to include(flash_message)
    end
  end

  describe 'POST /create' do
    subject(:request) do
      post '/shopping_carts/books', params: { id: book_id }.to_json, headers: {
        'Accept' => 'text/vnd.turbo-stream.html',
        'Content-Type' => 'application/json'
      }
    end

    context 'when there is no current_user' do
      let(:book_id) { 1 }
      let(:flash_message) { 'You need to be logged in to do this action' }

      it_behaves_like 'a response with a flash message'
    end

    context 'when there is a current_user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'when the book does not exist' do
        let(:book_id) { :invalid }
        let(:flash_message) { 'Resource not available' }

        it_behaves_like 'a response with a flash message'
      end

      context 'when the book does not have stock' do
        let(:book) { create(:book, stock_quantity: 0) }
        let(:book_id) { book.id }
        let(:flash_message) { 'This book is out of stock :(' }


        it_behaves_like 'a response with a flash message'
      end

      context 'when the book has stock' do
        let(:book) { create(:book, stock_quantity: 10) }
        let(:book_id) { book.id }
        let(:flash_message) { 'Book added to your shopping cart!' }

        it_behaves_like 'a response with a flash message'

        it 'adds the Book to the shopping cart of the current_user' do
          expect { request }.to change(user.shopping_cart.books, :count).from(0).to(1)
        end
      end
    end
  end

  describe 'DELETE /delete' do
    subject(:request) do
      delete "/shopping_carts/books/#{book_id}", headers: {
        'Accept' => 'text/vnd.turbo-stream.html',
        'Content-Type' => 'application/json'
      }
    end

    context 'when there is no current_user' do
      let(:book_id) { 1 }
      let(:flash_message) { 'You need to be logged in to do this action' }

      it_behaves_like 'a response with a flash message'
    end

    context 'when there is a current_user' do
      let(:user) { create(:user) }

      before { sign_in(user) }

      context 'when a Book with the specified id cannot be found' do
        let(:book_id) { :invalid }
        let(:flash_message) { 'Resource not available' }

        it_behaves_like 'a response with a flash message'
      end

      context 'when a Book with the specified id can be found' do
        let(:book) { create(:book) }
        let(:book_id) { book.id }

        before { user.shopping_cart.books << book }

        it 'removes the book from the shopping cart' do
          expect { request }.to change(user.shopping_cart.books, :count).from(1).to(0)
        end
      end
    end
  end
end
