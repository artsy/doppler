class HealthController < ApplicationController
  skip_before_action :require_artsy_authentication, only: [:ping]

  def ping
    render json: {status: :ok}
  end
end
