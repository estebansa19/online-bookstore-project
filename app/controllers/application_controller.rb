class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private

  def turbo_flash_message(id, message)
    render turbo_stream: turbo_stream.replace(id, partial: 'shared/message', locals: { message: })
  end

  def authenticate_user
    return if current_user.present?

    alert = 'You need to be logged in to do this action'

    respond_to do |format|
      format.html { redirect_to root_path, flash: { alert: } }
      format.turbo_stream { turbo_flash_message('alert', alert) }
    end
  end

  def render_not_found_response
    alert = 'Resource not available'

    respond_to do |format|
      format.html { redirect_to root_path, flash: { alert: } }
      format.turbo_stream { turbo_flash_message('alert', alert) }
    end
  end
end
