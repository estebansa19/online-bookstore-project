class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private

  def render_flash_message(id, message)
    render turbo_stream: turbo_stream.replace(id, partial: 'shared/message', locals: { message: })
  end

  def authenticate_user
    return if current_user.present?

    respond_to do |format|
      format.html { redirect_to root_path, flash: { alert: 'You need to be logged in to do this action' } }
      format.turbo_stream { render_flash_message('alert', 'You need to be logged in to do this action') }
    end
  end

  def render_not_found_response
    render_flash_message('alert', 'Resource not available')
  end
end
