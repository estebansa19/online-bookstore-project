# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Books', type: :request do
  # TODO: Create a trait for admin users
  let(:user) { create(:user, admin: true) }

  shared_examples 'an action that needs an admin user' do
    context 'when there is no current_user' do
      it 'renders an error flash message' do
        request

        expect(flash[:alert]).to eq('You cannot access this resource')
      end

      it 'redirects the user to the root_path' do
        request

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the current user is not an admin' do
      it 'renders an error flash message' do
        request

        expect(flash[:alert]).to eq('You cannot access this resource')
      end

      it 'redirects the user to the root_path' do
        request

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET /index' do
    subject(:request) { get '/admin/books' }

    it_behaves_like 'an action that needs an admin user'

    context 'when the current user is admin' do
      before { sign_in(user) }

      it 'returns a http success response' do
        request

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /new' do
    subject(:request) { get '/admin/books/new' }

    it_behaves_like 'an action that needs an admin user'

    context 'when the current user is admin' do
      before { sign_in(user) }

      it 'returns a http success response' do
        request

        expect(response).to have_http_status(:success)
      end
    end
  end


  describe 'POST /create' do
    subject(:request) { post '/admin/books', params: { book: attributes_for(:book) } }

    it_behaves_like 'an action that needs an admin user'

    context 'when the current user is admin' do
      before { sign_in(user) }

      it 'redirects to the books index in admin' do
        request

        expect(response).to redirect_to(admin_books_path)
      end

      it 'creates a new book' do
        expect { request }.to change(Book, :count).from(0).to(1)
      end
    end
  end

  describe 'GET /edit' do
    subject(:request) { get "/admin/books/#{book_id}/edit" }

    let(:book_id) { :example }

    it_behaves_like 'an action that needs an admin user'

    context 'when the current user is admin' do
      before { sign_in(user) }

      context 'when the book with the id specified does not exist' do
        let(:book_id) { :invald }

        it 'returns an error flash_message' do
          request

          expect(flash[:alert]).to include('Resource not available')
        end
      end

      context 'when the book with the id specified exists' do
        let(:book_id) { create(:book).id }

        it 'returns a http success response' do
          request

          expect(response).to have_http_status(:success)
        end
      end
    end
  end

  describe 'PUT /update/:id' do
    subject(:request) { put "/admin/books/#{book_id}", params: { book: book_params } }

    let(:book_id) { :example }

    let(:book_params) do
      {
        title: 'new title',
        author: 'Optimus Prime',
        description: 'new description',
        price: 666,
        pages_number: 123,
        stock_quantity: 777
      }
    end

    it_behaves_like 'an action that needs an admin user'

    context 'when the current user is admin' do
      before { sign_in(user) }

      context 'when the book with the id specified does not exist' do
        let(:book_id) { :invald }

        it 'returns an error flash_message' do
          request

          expect(flash[:alert]).to include('Resource not available')
        end
      end

      context 'when the book with the id specified exists' do
        let(:book) { create(:book) }
        let(:book_id) { book.id }

        it 'redirects the user to the books index in admin' do
          request

          expect(response).to redirect_to(admin_books_path)
        end

        it 'updates the book attributes' do
          request

          expect(book.reload).to have_attributes(book_params)
        end
      end
    end
  end

  describe 'DELETE /delete' do
    subject(:request) { delete "/admin/books/#{book_id}" }

    let(:book_id) { :example }

    it_behaves_like 'an action that needs an admin user'

    context 'when the current user is admin' do
      before { sign_in(user) }

      context 'when the book with the id specified does not exist' do
        let(:book_id) { :invald }

        it 'returns an error flash_message' do
          request

          expect(flash[:alert]).to include('Resource not available')
        end
      end

      context 'when the book with the id specified exists' do
        let!(:book) { create(:book) }
        let(:book_id) { book.id }

        it 'redirects the user to the books index in admin' do
          request

          expect(response).to redirect_to(admin_books_path)
        end

        it 'deletes the book' do
          expect { request }.to change { Book.count }.from(1).to(0)
        end
      end
    end
  end
end
