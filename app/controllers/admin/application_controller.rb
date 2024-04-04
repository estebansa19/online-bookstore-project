# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user

    private

    def authenticate_user
      return if current_user.present? && current_user.admin?

      respond_to do |format|
        format.html { redirect_to root_path, flash: { alert: 'You cannot access this resource' } }
        format.turbo_stream { render_flash_message('alert', 'You cannot access this resource') }
      end
    end
  end
end
