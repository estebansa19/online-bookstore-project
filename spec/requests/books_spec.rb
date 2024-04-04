# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /index' do
    it 'returns a http success response' do
      get '/books'

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    context 'when the Book does not exist' do
      before { get '/books/invalid' }

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash message' do
        expect(flash[:alert]).to eq('Not found')
      end
    end

    context 'when the Book exists' do
      let(:book) { create(:book) }

      before { get "/books/#{book.id}" }

      it 'returns a http success response' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
