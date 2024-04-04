# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend

  before_action :set_book, only: :show

  def index
    @pagy, @records = pagy(Book.order(:title))
  end

  def show
  end

  private

  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: { alert: 'Not found' }
  end
end
